@echo off
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

call :ColorText 0a "S"
call :ColorText 0b "a"
call :ColorText 0c "n"
call :ColorText 0d "s"
call :ColorText 0e "i"
call :ColorText 0f "r"
call :ColorText 0a "o"

pause

:ColorText
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1

goto :eof

