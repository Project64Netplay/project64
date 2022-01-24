@ECHO OFF
SETLOCAL

for /f "delims=" %%a in ('WHERE 7z 2^>nul') do set "zip=%%a"

if "%zip%" == "" (
	if exist "C:\Program Files\7-Zip\7z.exe" (
		set "zip=C:\Program Files\7-Zip\7z.exe"
	) else (
		echo can not find 7z.exe
		goto :EndErr
	)
)

set ZipFileName=Project64-Netplay
if not "%1" == "" set ZipFileName=%1
if "%~2" == "x64" set VSPlatform=64


SET current_dir=%cd%
cd /d %~dp0..\..\
SET base_dir=%cd%
cd /d %current_dir%

IF EXIST "%base_dir%\Package" rmdir /S /Q "%base_dir%\Package"
IF %ERRORLEVEL% NEQ 0 GOTO EndErr
IF NOT EXIST "%base_dir%\Package" mkdir "%base_dir%\Package"
IF %ERRORLEVEL% NEQ 0 GOTO EndErr

rd "%base_dir%\Bin\Package" /Q /S > NUL 2>&1
md "%base_dir%\Bin\Package"
md "%base_dir%\Bin\Package\Config"
md "%base_dir%\Bin\Package\Config\Cheats"
md "%base_dir%\Bin\Package\Config\Enhancements"
md "%base_dir%\Bin\Package\Plugin%VSPlatform%"
md "%base_dir%\Bin\Package\Plugin%VSPlatform%\Audio"
md "%base_dir%\Bin\Package\Plugin%VSPlatform%\GFX"
md "%base_dir%\Bin\Package\Plugin%VSPlatform%\Input"
md "%base_dir%\Bin\Package\Plugin%VSPlatform%\RSP"
md "%base_dir%\Bin\Package\Save"
md "%base_dir%\Bin\Package\Save\Backup"

IF EXIST "%base_dir%\Plugin%VSPlatform%\GFX\GLideN64" (
md "%base_dir%\Bin\Package\Plugin%VSPlatform%\GFX\GLideN64"
copy "%base_dir%\Plugin%VSPlatform%\GFX\GLideN64\GLideN64.dll" "%base_dir%\Bin\Package\Plugin%VSPlatform%\GFX\GLideN64\GLideN64.dll"
copy "%base_dir%\Plugin%VSPlatform%\GFX\GLideN64\*.ini" "%base_dir%\Bin\Package\Plugin%VSPlatform%\GFX\GLideN64"
md "%base_dir%\Bin\Package\Plugin%VSPlatform%\GFX\GLideN64\translations"
copy "%base_dir%\Plugin%VSPlatform%\GFX\GLideN64\translations\*.Lang" "%base_dir%\Bin\Package\Plugin%VSPlatform%\GFX\GLideN64\translations"
)

copy "%base_dir%\Bin\Release%VSPlatform%\Project64.exe" "%base_dir%\Bin\Package"
copy "%base_dir%\Config\Video.rdb" "%base_dir%\Bin\Package\Config"
copy "%base_dir%\Config\Audio.rdb" "%base_dir%\Bin\Package\Config"
copy "%base_dir%\Config\Cheats\*.cht" "%base_dir%\Bin\Package\Config\Cheats"
copy "%base_dir%\Config\Enhancements\*.enh" "%base_dir%\Bin\Package\Config\Enhancements"
copy "%base_dir%\Config\Project64.rdb" "%base_dir%\Bin\Package\Config"
copy "%base_dir%\Config\Project64.rdx" "%base_dir%\Bin\Package\Config"
copy "%base_dir%\Plugin%VSPlatform%\Audio\Jabo_Dsound.dll" "%base_dir%\Bin\Package\Plugin%VSPlatform%\Audio"
copy "%base_dir%\Plugin%VSPlatform%\GFX\GlideN64.dll" "%base_dir%\Bin\Package\Plugin%VSPlatform%\GFX"
copy "%base_dir%\Plugin%VSPlatform%\Input\PJ64_NRage.dll" "%base_dir%\Bin\Package\Plugin%VSPlatform%\Input"
copy "%base_dir%\Plugin%VSPlatform%\Input\netplay_input_plugin.dll" "%base_dir%\Bin\Package\Plugin%VSPlatform%\Input"
copy "%base_dir%\Plugin%VSPlatform%\RSP\RSP 1.7.dll" "%base_dir%\Bin\Package\Plugin%VSPlatform%\RSP"
copy "%base_dir%\Plugin%VSPlatform%\Updater\7z.dll" "%base_dir%\Bin\Package\Plugin%VSPlatform%\Updater"
copy "%base_dir%\Plugin%VSPlatform%\Updater\7z.exe" "%base_dir%\Bin\Package\Plugin%VSPlatform%\Updater"
copy "%base_dir%\Plugin%VSPlatform%\Updater\wget.exe" "%base_dir%\Bin\Package\Plugin%VSPlatform%\Updater"

copy "%base_dir%\Replace.bat" "%base_dir%\Bin\Package\"
copy "%base_dir%\Update Emulator.bat" "%base_dir%\Bin\Package\"

copy "%base_dir%\Save\*.eep" "%base_dir%\Bin\Package\Save"
copy "%base_dir%\Save\*.sra" "%base_dir%\Bin\Package\Save"
copy "%base_dir%\Save\Backup\*.eep" "%base_dir%\Bin\Package\Save\Backup"
copy "%base_dir%\Save\Backup\*.sra" "%base_dir%\Bin\Package\Save\Backup"
cd %base_dir%\Bin\Package
"%zip%" a -tzip -r "%base_dir%\Package\%ZipFileName%" *
cd /d %current_dir%

echo Package %ZipFileName% created

copy "%base_dir%\Package\Project64-Netplay.zip" "Bin\Release\"

goto :end


:EndErr
ENDLOCAL
echo Build failed
exit /B 1

:End
ENDLOCAL
exit /B 0
