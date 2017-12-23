# DVD Creation Scripts #

## Summary ##

Batch scripts that can be used to burn DVDs from video files.

## Third Party Software ##

This repository contains only the scripts with the commands, not the actual programs themselves. To use the scripts, you will also need the following 3rd-party software:

 - ffmpeg
 - dvdauthor
 - mkisofs
 
In addition, Windows users will need ImgBurn to burn the ISO file to disk (follow the instructions in the text file to avoid any potentially unwanted software that may come with some ImgBurn downloads).

The folder containing the scripts will also contain a text file with instructions on how to get the 3rd-party programs.

## Legal ##

Users are responsible for complying with all applicable patent and copyright laws in their respective countries.

## Operating System Support ##

The batch script for Mac has the most options.
If you need more options for Windows or support for Linux, you can look at the Mac script and copy what you need.

## Usage ##

1. Find the folder for your operating system and download the script.
2. Follow the instructions in the text file for downloading the 3rd-party programs.
3. Open the script in a text editor and update the folder paths to match your computer.
3. Place the video file in the appropriate folder.
4. Place a DVD in the drive.
5. Double-click the script.

## Operation Notes ##

The script will create intermediate files and folders as part of the process of creating the DVD. Before creating a file or folder, the script will check for its existence. If it already exists, that step will be skipped. So if you want to start over, delete all the generated files and folders.

## License ##

Public Domain