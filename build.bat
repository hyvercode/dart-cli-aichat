@echo off
set APP_NAME=dart_cli_chatai
set ENTRY=bin\dart_cli_chatai.dart
set BUILD_DIR=build

echo Building %APP_NAME%...
if not exist %BUILD_DIR% mkdir %BUILD_DIR%
dart compile exe %ENTRY% -o %BUILD_DIR%\%APP_NAME%.exe

if %ERRORLEVEL%==0 (
  echo ✅ Build success!
  echo Run: %BUILD_DIR%\%APP_NAME%.exe
) else (
  echo ❌ Build failed.
)
pause