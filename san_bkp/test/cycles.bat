@echo off
cls
setlocal EnableDelayedExpansion EnableExtensions

@ECHO OFF
: Sets the proper date and time stamp with 24Hr Time for log file naming
: convention

SET HOUR=%time:~0,2%
SET dtStamp9=%date:~-4%%date:~3,2%%date:~7,2%_0%time:~1,1%%time:~3,2%%time:~6,2% 
SET dtStamp24=%date:~-4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%

if "%HOUR:~0,1%" == " " (SET dtStamp=%dtStamp9%) else (SET dtStamp=%dtStamp24%)

ECHO %dtStamp%

PAUSE



set settings="%~dp0..\config\settings.lst"

rem Parsing the settings
rem format: key=value; some description

echo %settings%
if not exist %settings% (
		echo not existed
		pause > nul
		exit
)

for /F "usebackq eol=; tokens=1,2 delims==" %%a in (%settings%) do (
		if %%a==arc set arc=%%b
		if %%a==days (
			set days=%%b
			call :parseDays
			);

);
		echo arc=!arc!
		echo days=!days!
		echo day1=!day1!
		echo day2=!day2!
		echo day3=!day3!	
		echo day4=!day4!
		
		pause

:parseDays
for /F "tokens=1-4 delims=," %%a in ("%days%") do (
		set day1=%%a
		set day2=%%b
		set day3=%%c
		set day4=%%d			
)
exit /b

if not exist !exclus! (
		call :color 0c " * Can't create exclusions.lst"
		pause > nul
		exit


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