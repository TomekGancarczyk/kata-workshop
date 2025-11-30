@echo off
REM Run script for Windows (native cmd)

cd /d "%~dp0\..\.."
build\src\chocolate-doom.exe -iwad .workshop\wads\freedoom1.wad %*
