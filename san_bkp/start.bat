@echo off

:: TODO

:: Find executies and settings
:: Parsing date
:: Parsing settings file
:: Parsing tasks
:: Write logs

setlocal EnableDelayedExpansion EnableExtensions

rem Colored text engine
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

rem Prepare a file "X" with only one dot
<nul > X set /p ".=."

rem example: call :color 0c,0a,0b,0d "text"

echo.
echo.
call :color 9f " * San Backup Free v0.1 May'2013"
echo.
echo.
echo.
echo.


rem Init the program
if not exist "%~dp0.\config\settings.lst" (
		call :color 0c " * Settings file wasn't found. Reistall the program."
		echo.
		pause > nul
		exit
) else (
		::set settings=.\config\settings.lst
		set settings="%~dp0.\config\settings.lst"
)

if not exist "%~dp0.\config\tasks.lst" (
		call :color 0c " * You need to have any tasks in the list. "
		call :color 0e "Please, look readme.txt"
		echo.
		pause > nul
		exit
) else (
		::set settings=.\config\settings.lst
		set settings="%~dp0.\config\settings.lst"
)

rem Parsing the settings
rem format: key=value; some description
for /F "usebackq eol=; tokens=1,2 delims==" %%a in (%settings%) do (
		if %%a==arc set arc=%%b
)

rem Parsing the tasks
rem format: "source"<tab>"destination"<tab>"daily|full|auto"<tab>"zip|7z|rar|no"<tab>"0-9"
for /F "usebackq skip=2 eol=; tokens=1-5 delims=	" %%a in (.\config\tasks.lst) do (

		set V1=%%a
		set V2=%%b
		set V3=%%c
		set V4=%%d
		set V5=%%e
		
		echo var1=!V1!
		echo var2=!V2!
		echo var3=!V3!
		echo var4=!V4!
		echo var5=!V5!
		
		if not exist !V1! (
			echo * Source !V1! wasn't found
		);
		
		if not exist !V2! (
			echo * Destination !V2! wasn't found
			echo * Trying to create ...
			mkdir !V2!
			if not exist !V2! (
				echo * Can't to create destination !V2!
				echo * Copying to SYSTEMP
				);
		);
		
		if !V3!=="daily" (
			set method=daily
			xcopy /D /E /H /I /Y /EXCLUDE:.\config\exclusions.lst !V1! !V2!
			);
		if !V3!=="full" (
			set method=full
			xcopy /E /H /I /Y /EXCLUDE:.\config\exclusions.lst !V1! !V2!
			); 
		if !V3!=="auto" (
			set method=auto
			
			);
			
		echo method=!method!
		
)

echo * Everything was OK
pause > nul

:color
set "param=^%~2" !
set "param=!param:"=\"!"
findstr /p /A:%1 "." "!param!\..\X" nul
<nul set /p ".=%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%"
exit /b
