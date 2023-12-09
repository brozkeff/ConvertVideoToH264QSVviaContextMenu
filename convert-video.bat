@echo off
setlocal enabledelayedexpansion

set i=%~n1
set x=%~x1
set o=%i%.mp4
if exist %o% (
  set o=%i%-h264.mp4
)

ffmpeg -i "%i%%x%" -c:v h264_qsv -preset:v fast -q:v 27 -c:a aac -strict experimental -q:a 1 "%o%"

endlocal
exit
