@ECHO OFF

SET OSALANG=PTBR
SET OSAFILE=%3
SET OSAARCH=COM

if "%1"=="dos"  set OSAARCH=COM
if "%1"=="bios"  set OSAARCH=SYS
if "%1"=="bin"  set OSAARCH=SYS
if "%1"=="sys"  set OSAARCH=SYS
if "%1"=="DOS"  set OSAARCH=COM
if "%1"=="BIOS"  set OSAARCH=SYS
if "%1"=="BIN"  set OSAARCH=SYS
if "%1"=="SYS"  set OSAARCH=SYS
if "%2"=="PT"  set OSALANG=PTBR
if "%2"=="EN"  set OSALANG=ENUS
if "%2"=="pt"  set OSALANG=PTBR
if "%2"=="en"  set OSALANG=ENUS
if "%1"=="" goto :erro
if "%3"=="" set OSAFILE=%2
if "%2"=="" set OSAFILE=%1

CALL BIN\%OSALANG%\OSASM%OSAARCH%.COM %OSAFILE%
goto :fim
:erro
echo Usage: OSASM [DOS/BIN/SYS/BIOS] [PT/EN] [FILENAME]
:fim


