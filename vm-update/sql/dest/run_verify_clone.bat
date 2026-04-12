@echo off
setlocal

REM ===== Verify cloned data on PDBCLONE with app_user =====

set "ORACLE_HOME=C:\app\oracle\product\19.0.0\dbhome_1"
set "SQLPLUS=%ORACLE_HOME%\bin\sqlplus.exe"
set "SCRIPT_DIR=%~dp0"
set "SQL_FILE=%SCRIPT_DIR%verify_clone.sql"
set "LOG_DIR=%SCRIPT_DIR%logs"

if not exist "%LOG_DIR%" mkdir "%LOG_DIR%"

echo [INFO] Verifying cloned data on PDBCLONE with app_user...
echo [INFO] Make sure PDBCLONE is defined in tnsnames.ora before running this step.

if not exist "%SQLPLUS%" (
  echo [ERROR] sqlplus.exe not found.
  pause >nul
  exit /b 1
)

if not exist "%SQL_FILE%" (
  echo [ERROR] SQL file not found.
  pause >nul
  exit /b 1
)

"%SQLPLUS%" app_user/Oracle123!@PDBCLONE @"%SQL_FILE%" > "%LOG_DIR%\verify_clone.log" 2>&1

if errorlevel 1 (
  echo [ERROR] Clone verification failed.
  echo [ERROR] Check log: %LOG_DIR%\verify_clone.log
  pause >nul
  exit /b 1
)

echo [INFO] Clone verification completed.
echo [INFO] Check log: %LOG_DIR%\verify_clone.log
pause >nul

endlocal
