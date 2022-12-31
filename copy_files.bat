@echo off

echo Choose a target directory:
echo 1. Vanilla
echo 2. Fabric
echo 3. Technic
choice /c:123 /n
set "target_dir=%errorlevel%"

if "%target_dir%"=="1" set "target_dir=Vanilla"
if "%target_dir%"=="2" set "target_dir=MultiMC"
if "%target_dir%"=="3" set "target_dir=Forge"

if not exist "%target_dir%" (
  echo Error: target directory does not exist
  exit /b 1
)

setlocal enabledelayedexpansion

set files=
for /r . %%f in (*) do (
  if "%%~nxf" NEQ "copy_files.bat" (
    set files=!files! "%%~f"
  )
)

set copied=0

for %%f in (%files%) do (
  if exist "%target_dir%\%%~nxf" (
    :prompt_overwrite
    echo File %%~nxf already exists in the target directory. Do you want to overwrite it? (Yes/No)
    set /p answer=
    if /i "%answer%"=="yes" (
      copy "%%~f" "%target_dir%"
      set copied=1
    ) else if /i "%answer%"=="no" (
      goto :continue
    ) else (
      echo Please enter Yes or No
      goto :prompt_overwrite
    )
  ) else (
    copy "%%~f" "%target_dir%"
    set copied=1
  )
  :continue
)

if %copied% == 1 (
  echo Files copied successfully
) else (
  echo No files were copied
)
