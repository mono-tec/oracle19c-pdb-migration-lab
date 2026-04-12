@echo off
setlocal

REM ===== Create clone_user on source PDBSRC =====

set "ORACLE_HOME=C:\app\oracle\product\19.0.0\dbhome_1"
set "SQLPLUS=%ORACLE_HOME%\bin\sqlplus.exe"
set "SCRIPT_DIR=%~dp0"
set "SQL_FILE=%SCRIPT_DIR%create_clone_user.sql"
set "LOG_DIR=%SCRIPT_DIR%logs"

if not exist "%LOG_DIR%" mkdir "%LOG_DIR%"

echo [INFO] Creating clone_user on source PDBSRC...

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

"%SQLPLUS%" / as sysdba @"%SQL_FILE%" > "%LOG_DIR%\create_clone_user.log" 2>&1

if errorlevel 1 (
  echo [ERROR] clone_user creation failed.
  echo [ERROR] Check log: %LOG_DIR%\create_clone_user.log
  pause >nul
  exit /b 1
)

echo [INFO] clone_user creation completed.
echo [INFO] Check log: %LOG_DIR%\create_clone_user.log
pause >nul

endlocal
