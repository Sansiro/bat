@echo off

:: TODO

:: Find executies and settings
:: Parsing date
:: Parsing settings file
:: Parsing tasks
:: Write logs

setlocal EnableDelayedExpansion EnableExtensions

rem Colored text engine
rem example: call :color 0c,0a,0b,0d "text"

call :initColorPrint

call :color 07 "Thank for colored text code http://stackoverflow.com/users/1012053/dbenham"
echo.
echo.
call :color 9f " * San Backup Free v0.1 May'2013" /n
echo.

rem Init the program

set settings=%~dp0.\config\settings.lst
echo %settings%
if not exist %settings% (
		call :color 0c " * Settings file wasn't found. Reistall the program."
		echo.
		pause > nul
		exit
)

set tasks=%~dp0.\config\tasks.lst
echo %tasks%
if not exist %tasks% (
		call :color 0c " * You need to have any tasks in the list. "
		call :color 0e "Please, look readme.txt"
		echo.
		pause > nul
		exit
)

set exclus=%~dp0.\config\exclusions.lst
echo %exclus%
if not exist %exclus% (
		call :color 0c " * Exclusion file missing or unreachable."
		call :color 0e "Trying to create new file exclusions.lst"
		echo.
		echo .lck >> "%exclus%"
)

if not exist %exclus% (
		call :color 0c " * Can't create exclusions.lst"
		pause > nul
		exit
)

rem Parsing the date
rem format: YYYYMMDD_hhmmss

set cDate=%date:~-4%%date:~3,2%%date:~7,2%
set cTime=%time:~0,2%%time:~3,2%%time:~6,2%
set cHour=%time:~0,2%
if "%cHour:~0,1%" == " " (set cTime=0%time:~1,1%%time:~3,2%%time:~6,2%)

call :color 0b "%cDate%_%cTime%" /n
 
 
rem Parsing the settings
rem format: key=value; some description

for /F "usebackq eol=; tokens=1,2 delims==" %%a in (%settings%) do (
		if %%a==arc set arc=%%b
		if %%a==days (
			set days=%%b
			call :parseDays
			);
);
		echo arc=!arc!
		echo day1=!day1!
		echo day2=!day2!
		echo day3=!day3!	
		echo day4=!day4!

rem Parsing the tasks
rem format: "source"<tab>"destination"<tab>"daily|full|auto"<tab>"zip|7z|rar|no"<tab>"0-9"

for /F "usebackq skip=2 eol=; tokens=1-5 delims=	" %%a in (%tasks%) do (

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
			call :color 0c " * Source !V1! wasn't found"
			echo.
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
			xcopy /D /E /H /I /Y /EXCLUDE:!exclus! !V1! !V2!
			);
		if !V3!=="full" (
			set method=full
			xcopy /E /H /I /Y /EXCLUDE:!exclus! !V1! !V2!
			); 
		if !V3!=="auto" (
			set method=auto
			rem if today's date is one of days of full bkp 
			);
			
		echo method=!method!
		
)



call :color 0a " * Everything was OK"
pause > nul

call :cleanupColorPrint

:parseDays
for /F "tokens=1-4 delims=," %%a in ("%days%") do (
		set day1=%%a
		set day2=%%b
		set day3=%%c
		set day4=%%d			
)
exit /b

:color Color  Str  [/n]
setlocal
set "str=%~2"
call :colorVar %1 str %3
exit /b

:colorVar  Color  StrVar  [/n]
if not defined %~2 exit /b
setlocal enableDelayedExpansion
set "str=a%DEL%!%~2:\=a%DEL%\..\%DEL%%DEL%%DEL%!"
set "str=!str:/=a%DEL%/..\%DEL%%DEL%%DEL%!"
set "str=!str:"=\"!"
pushd "%temp%"
findstr /p /A:%1 "." "!str!\..\x" nul
if /i "%~3"=="/n" echo(
exit /b

:initColorPrint
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set "DEL=%%a"
<nul >"%temp%\x" set /p "=%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%.%DEL%"
exit /b

:cleanupColorPrint
del "%temp%\x"
exit /b


