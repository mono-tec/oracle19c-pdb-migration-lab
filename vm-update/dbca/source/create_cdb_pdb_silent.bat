@echo off
setlocal

REM ===== Oracle 19c DBCA Silent Create (Source) =====
REM GitHub から取得した vmupdate\dbca フォルダを VM 上に配置し、
REM この bat ファイルを実行してください。

set "ORACLE_HOME=C:\app\oracle\product\19.0.0\dbhome_1"
set "DBCA_EXE=%ORACLE_HOME%\bin\dbca.bat"
set "SCRIPT_DIR=%~dp0"
set "RESPONSE_FILE=%SCRIPT_DIR%dbca_create_cdb_pdb.rsp"
set "LOG_DIR=%SCRIPT_DIR%logs"

if not exist "%LOG_DIR%" mkdir "%LOG_DIR%"

echo [INFO] Source DBCA silent create started.
echo [INFO] dbca.exe = %DBCA_EXE%
echo [INFO] response = %RESPONSE_FILE%
echo [INFO] log dir  = %LOG_DIR%

if not exist "%DBCA_EXE%" (
  echo [ERROR] dbca.bat not found.
  echo.
  echo [ERROR] Press any key to exit...
  pause >nul
  exit /b 1
)

if not exist "%RESPONSE_FILE%" (
  echo [ERROR] response file not found.
  echo.
  echo [ERROR] Press any key to exit...
  pause >nul
  exit /b 1
)

call "%DBCA_EXE%" -silent -createDatabase -responseFile "%RESPONSE_FILE%" > "%LOG_DIR%\create_source_stdout.log" 2>&1

if errorlevel 1 (
  echo [ERROR] Source DBCA silent create failed.
  echo [ERROR] Check batch log: %LOG_DIR%\create_source_stdout.log
  echo.
  echo [ERROR] Press any key to exit...
  pause >nul
  exit /b 1
)

echo [INFO] Source DBCA silent create completed.
echo [INFO] Check log: %LOG_DIR%\create_source_stdout.log
echo.
echo [INFO] Press any key to exit...
pause >nul

endlocal
