@echo off
set tempfile="%temp%\1489AFE4.TMP"
set regkey="HKEY_CURRENT_USER\SOFTWARE\Licenses"
set has_error=0

tasklist | find /I "devenv.exe" > NUL
if %errorlevel% == 0 (
	echo Please close Visual Studio and try again.
	exit /B 1
)

echo.

echo Resetting Visual Assist X trial period
echo Deleting registry key %regkey% ...
reg query %regkey% >nul 2>&1
if %errorlevel% == 0 (
	reg delete /f %regkey% >nul 2>&1
	if %errorlevel% == 1 (
		echo Registry key was found but not deleted.
		set has_error=1
	)
)
echo.

echo Deleting temporary file %tempfile% ...
del %tempfile%>NUL

echo.

if %has_error% == 0 (
	echo Done. Visual Assist X should have forgotten about your trial period now.
) else (
	echo Done. However, maybe not everything worked out right.
)

exit /B %has_error%