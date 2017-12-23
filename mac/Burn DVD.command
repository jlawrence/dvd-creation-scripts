#!/bin/bash
set -o errexit

# Uncomment the below line for verbose output
#set -x

main() {
	# File locations - Update these to match the locations on your computer
	local video_folder="/Users/josh/Desktop/Videos" # folder containing the video to burn to DVD
	local bin_folder="/Users/josh/Desktop/bin" # folder containing the 3rd-party binaries

	#=== STEP 1 - Get file name ===#
	# OPTION 1a. Prompt the user to enter a specific file name.
	echo "Enter name of file (including extension)."
	read short_filename
	local input_filename=$video_folder/$short_filename
	
	# OPTION 1b. Get the most recently created .mp4 file in the video folder. To use this uncomment the below commands and comment out the OPTION 1a commands.
	#unset -v input_filename
	#for filename in "$video_folder"/*.mp4; do
	#  [[ $filename -nt $input_filename ]] && input_filename=$filename
	#done
		
	#=== Step 2 - Transcode to MPEG-2 DVD format using ffmpeg if file does not already exist ===#
	local transcoded_filename="${input_filename%.*} DVD.mpg"
	
	# OPTION 2a 
	# Use default settings
	[ ! -e "$transcoded_filename" ] && "$bin_folder/ffmpeg" -i "$input_filename" -aspect 16:9 -target ntsc-dvd "$transcoded_filename"
	
	# OPTION 2b
	# If you have a long video file and you have trouble fitting it onto a DVD, uncomment the below command and comment out the OPTION 2a command.
	# You can adjust following quality settings to get the size down:
	# -b:v (the video bit rate)
	# -maxrate (the maximum video bit rate)
	# -b:a (the audio bit rate)
	
	#[ ! -e "$transcoded_filename" ] && "$bin_folder/ffmpeg" -i "$input_filename" -aspect 16:9  -c:v mpeg2video -c:a ac3 -f dvd -s 720x480 -r 29.97002997 -pix_fmt yuv420p -g 18 -b:v 5000k -maxrate 8000000 -minrate 0 -bufsize 1835008 -packetsize 2048 -muxrate 10080000 -b:a 224000 -ar 48000 "$transcoded_filename"
	

	#=== Step 3 - Create folder with files for DVD ===#
	local dvd_folder="${input_filename%.*} DVD"
	[ ! -e "$dvd_folder" ] && (
	export VIDEO_FORMAT=NTSC
	mkdir "$dvd_folder"
	"$bin_folder/dvdauthor" --title -f "$transcoded_filename" -o "$dvd_folder"
	"$bin_folder/dvdauthor" -T -o "$dvd_folder"
	)

	#=== Step 4 - Create ISO ===#
	local iso_filename="${input_filename%.*} DVD.iso"
	[ ! -e "$iso_filename" ] && "$bin_folder/mkisofs" -v -V DVD -dvd-video -o "$iso_filename" "$dvd_folder"

	#=== Step 5 - Burn ISO to DVD Disc ===#
	hdiutil burn "$iso_filename"
}

main