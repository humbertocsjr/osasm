@ECHO OFF

SET OSALANG=PT
SET OSAFILE=%3
SET OSAARCH=D

if "%1"=="dos"  set OSAARCH=D
if "%1"=="bios"  set OSAARCH=B
if "%1"=="bin"  set OSAARCH=B
if "%1"=="DOS"  set OSAARCH=D
if "%1"=="BIOS"  set OSAARCH=B
if "%1"=="BIN"  set OSAARCH=B
if "%2"=="PT"  set OSALANG=%2
if "%2"=="EN"  set OSALANG=%2
if "%2"=="pt"  set OSALANG=%2
if "%2"=="en"  set OSALANG=%2
if "%1"=="" goto :erro
if "%3"=="" set OSAFILE=%2
if "%2"=="" set OSAFILE=%1

CALL BIN\OSASM%OSAARCH%%OSALANG%.COM %OSAFILE%
goto :fim
:erro
echo Usage: OSASM [DOS/BIN/BIOS] [PT/EN] [FILENAME]
:fim


