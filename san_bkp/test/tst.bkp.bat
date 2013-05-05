@echo off
setlocal EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

rem Prepare a file "X" with only one dot
<nul > X set /p ".=."

set STRING=1;;3;4
echo %STRING%
set STRING=#%STRING:;=;#%

for /F "tokens=1,2,3,4 delims=;" %%a in ("%STRING%") do (
  set V1=%%a
  set V1=!V1:~1!
  set V2=%%b
  set V2=!V2:~1!
  set V3=%%c
  set V3=!V3:~1!
  set V4=%%d
  set V4=!V4:~1!
)

call :ColorText 0c "var1=%V1%"
echo.
call :ColorText 0a "var2=%V2%"
echo.
call :ColorText 0b "var3=%V3%"
echo.
call :ColorText 0d "var3=%V4%"
echo.

pause > nul

:ColorText
set "param=^%~2" !
set "param=!param:"=\"!"
findstr /p /A:%1 "." "!param!\..\X" nul
<nul set /p ".=%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%"
exit /b
.