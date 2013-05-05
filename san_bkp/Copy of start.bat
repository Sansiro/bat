@echo off

echo ===================================
echo * San Backup Free v0.1        '2013
echo ===================================
echo.

setlocal EnableDelayedExpansion EnableExtensions

:: TODO

:: Find executies and settings
:: Parsing date
:: Parsing settings file
:: Parsing tasks
:: Write logs

rem Init the program

if not exist "%~dp0.\settings\settings.lst" (
		echo * Settings file wasn't found. Reistall the program.
		pause > nul
		exit
) else (
		::set settings=.\settings\settings.lst
		set settings="%~dp0.\settings\settings.lst"
)

if not exist "%~dp0.\settings\tasks.lst" (
		echo * You need to have .\settings\tasks.lst 
		echo * format "source"<tab>"destination"<tab>"daily|full|auto"<tab>"zip|7z|rar|no"<tab>"0-9"
		pause > nul
		exit
) else (
		::set settings=.\settings\settings.lst
		set settings="%~dp0.\settings\settings.lst"
)

rem Parsing the settings
rem format: key=value; some description

for /F "usebackq eol=; tokens=1,2 delims==" %%a in (%settings%) do (
		if %%a==arc set arc=%%b
)

rem Parsing the tasks
rem format: "source"<tab>"destination"<tab>"daily|full|auto"<tab>"zip|7z|rar|no"<tab>"0-9"

for /F "usebackq skip=2 eol=; tokens=1-5 delims=	" %%a in (.\settings\tasks.lst) do (

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
			xcopy /D /E /H /I /Y /EXCLUDE:.\settings\exclusions.lst !V1! !V2!
			);
		if !V3!=="full" (
			set method=full
			xcopy /E /H /I /Y /EXCLUDE:.\settings\exclusions.lst !V1! !V2!
			); 
		if !V3!=="auto" (
			set method=auto
			
			);
			
		echo method=!method!
		
)

echo * Everything was OK
pause > nul
