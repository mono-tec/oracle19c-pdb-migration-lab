@echo off
setlocal

REM ===== Oracle 19c Silent Install =====
REM GitHub から取得した oracle-install フォルダを VM 上に配置し、
REM この bat ファイルを実行してください。
REM
REM 事前に Oracle 19c の ZIP を展開し、setup.exe の場所を確認してください
REM   C:\app\oracle\product\19.0.0\dbhome_1

set "SETUP_EXE=C:\app\oracle\product\19.0.0\dbhome_1\setup.exe"
set "SCRIPT_DIR=%~dp0"
set "RESPONSE_FILE=%SCRIPT_DIR%db_install.rsp"
set "LOG_DIR=%SCRIPT_DIR%logs"

if not exist "%LOG_DIR%" mkdir "%LOG_DIR%"

echo [INFO] Oracle 19c silent install started.
echo [INFO] setup.exe = %SETUP_EXE%
echo [INFO] response  = %RESPONSE_FILE%
echo [INFO] log dir   = %LOG_DIR%

if not exist "%SETUP_EXE%" (
  echo [ERROR] setup.exe not found.
  exit /b 1
)

if not exist "%RESPONSE_FILE%" (
  echo [ERROR] response file not found.
  exit /b 1
)

"%SETUP_EXE%" -silent -waitforcompletion -responseFile "%RESPONSE_FILE%" > "%LOG_DIR%\install_stdout.log" 2>&1

if errorlevel 1 (
  echo [ERROR] Oracle 19c silent install failed.
  echo [ERROR] Check batch log: %LOG_DIR%\install_stdout.log
  echo [ERROR] Check Oracle installer logs: C:\app\oraInventory\logs

  echo.
  echo [ERROR] Press any key to exit...
  pause >nul

  exit /b 1
)

echo [INFO] Oracle 19c silent install completed.
echo [INFO] Check log: %LOG_DIR%\install_stdout.log

echo.
echo [INFO] Press any key to exit...
pause >nul
endlocal