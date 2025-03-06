:: Created by ChatGPT

@echo off
setlocal


:: Check if a filename is provided
if "%~1"=="" (
	set "filename=emptyfile.txt"
) else (
	set "filename=%~1"
)

:: Check for invalid characters in filename
echo %filename% | findstr /R /C:"[\\/:*?<>|]" >nul
if not errorlevel 1 (
	echo Error: Invalid filename! It contains forbidden characters.
	exit /b 1
)

:: Check write permissions in the current directory
echo. 2>test_write_permission.tmp
if errorlevel 1 (
	echo Error: No write permissions in this directory.
	exit /b 1
)
del test_write_permission.tmp

:: Check if the file already exists and is read-only
if exist "%filename%" (
	attrib "%filename%" | findstr /I "R" >nul
	if not errorlevel 1 (
		echo Error: The file "%filename%" is read-only.
		exit /b 1
	)
)

:: Create an empty file
type NUL > "%filename%" 2>nul

:: Check if the file was created successfully
if errorlevel 1 (
	echo Error: Failed to create the file "%filename%".
	exit /b 1
)

:: Output success mesage
echo Empty file "%filename%" created successfully.

endlocal

