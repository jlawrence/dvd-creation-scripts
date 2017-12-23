@echo ON

REM File locations
SET VideoFolder=C:\Users\Josh\Desktop\Videos
SET ExeFolder=C:\Users\Josh\Desktop\bin

REM Get most recent .mp4 file
FOR /F "delims=|" %%I IN ('DIR "%VideoFolder%\*.mp4" /B /O:D') DO SET FileName=%%~nI
SET "TranscodedFileName=%FileName% DVD.mpg"

REM Prompt user to enter name of mp4 file. Uncomment below lines and comment out above lines if you want to use this.
REM SET /p FileName="Enter name of mp4 file - Do not include the .mp4 file extension."
REM SET "TranscodedFileName=%FileName% DVD.mpg"


REM Transcode to MPEG-2 DVD format using ffmpeg
IF NOT EXIST "%VideoFolder%\%TranscodedFileName%" "%ExeFolder%\ffmpeg.exe" -i "%VideoFolder%\%FileName%.mp4" -aspect 16:9 -target ntsc-dvd "%VideoFolder%\%TranscodedFileName%"

REM Create DVD folder with files
SET "DvdFolder=%VideoFolder%\%FileName% DVD"
IF NOT EXIST "%DvdFolder%" (
mkdir "%DvdFolder%"
"%ExeFolder%\dvdauthor.exe" --title -f "%VideoFolder%\%TranscodedFileName%" -o "%DvdFolder%"
"%ExeFolder%\dvdauthor.exe" -T -o "%DvdFolder%"
)

REM Create ISO
SET "IsoFileName=%VideoFolder%\%FileName% DVD.iso"
IF NOT EXIST "%IsoFileName%" "%ExeFolder%\ImgBurn\ImgBurn.exe" /MODE ISOBUILD /BUILDMODE IMAGEFILE /SRC "%DvdFolder%\VIDEO_TS\|%DvdFolder%\AUDIO_TS\" /DEST "%IsoFileName%" /start /NOIMAGEDETAILS /close /FILESYSTEM "ISO9660 + UDF" /VOLUMELABEL "DVD"

REM Burn ISO to DVD Disc
"%ExeFolder%\ImgBurn\ImgBurn.exe" /MODE WRITE /SRC "%IsoFileName%" /start /SPEED 8X /VERIFY NO /EJECT YES /CLOSESUCCESS