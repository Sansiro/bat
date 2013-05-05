@echo off
setlocal enabledelayedexpansion
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

echo var1=%V1%
echo var2=%V2%
echo var3=%V3%
echo var4=%V4%
Pause