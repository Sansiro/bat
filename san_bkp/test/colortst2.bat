@echo off

echo Thank for color text code http://stackoverflow.com/users/1012053/dbenham

setlocal

call :initColorPrint

call :color 0a "a"
call :color 0b "b"
set "txt=^" & call :colorVar 0c txt
call :color 0d "<"
call :color 0e ">"
call :color 0f "&"
call :color 1a "|"
call :color 1b " "
call :color 1c "%%%%"
call :color 1d ^"""
call :color 1e "*"
call :color 1f "?"
call :color 2a "!"
call :color 2b "."
call :color 2c ".."
call :color 2d "/"
call :color 2e "\"
call :color 2f "q:" /n
echo(
set complex="c:\hello world!/.\..\\a//^<%%>&|!" /^^^<%%^>^&^|!\
call :colorVar 74 complex /n

call :cleanupColorPrint

pause

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

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