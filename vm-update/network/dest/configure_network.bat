@echo off
setlocal

REM ===== Oracle 19c Network Configure =====
REM GitHub から取得した vm-update\network\dest フォルダを VM 上に配置し、
REM この bat ファイルを管理者権限で実行してください。

set "ORACLE_HOME=C:\app\oracle\product\19.0.0\dbhome_1"
set "NETWORK_ADMIN=%ORACLE_HOME%\network\admin"
set "SCRIPT_DIR=%~dp0"
set "LISTENER_FILE=%SCRIPT_DIR%listener.ora"
set "TNS_FILE=%SCRIPT_DIR%tnsnames.ora"
set "LOG_DIR=%SCRIPT_DIR%logs"
set "LSNRCTL=%ORACLE_HOME%\bin\lsnrctl.exe"

if not exist "%LOG_DIR%" mkdir "%LOG_DIR%"
if not exist "%NETWORK_ADMIN%" mkdir "%NETWORK_ADMIN%"

echo [INFO] Oracle network configure started.
echo [INFO] ORACLE_HOME   = %ORACLE_HOME%
echo [INFO] NETWORK_ADMIN = %NETWORK_ADMIN%
echo [INFO] log dir       = %LOG_DIR%

if not exist "%LISTENER_FILE%" (
  echo [ERROR] listener.ora not found.
  echo.
  echo [ERROR] Press any key to exit...
  pause >nul
  exit /b 1
)

if not exist "%TNS_FILE%" (
  echo [ERROR] tnsnames.ora not found.
  echo.
  echo [ERROR] Press any key to exit...
  pause >nul
  exit /b 1
)

if not exist "%LSNRCTL%" (
  echo [ERROR] lsnrctl.exe not found.
  echo.
  echo [ERROR] Press any key to exit...
  pause >nul
  exit /b 1
)

copy /Y "%LISTENER_FILE%" "%NETWORK_ADMIN%\listener.ora" >nul
copy /Y "%TNS_FILE%" "%NETWORK_ADMIN%\tnsnames.ora" >nul

echo [INFO] listener.ora and tnsnames.ora copied.

netsh advfirewall firewall add rule name="Oracle Listener 1521" dir=in action=allow protocol=TCP localport=1521 > "%LOG_DIR%\firewall.log" 2>&1

echo [INFO] Windows Firewall rule applied.

call "%LSNRCTL%" stop > "%LOG_DIR%\lsnrctl_stop.log" 2>&1
call "%LSNRCTL%" start > "%LOG_DIR%\lsnrctl_start.log" 2>&1
call "%LSNRCTL%" status > "%LOG_DIR%\lsnrctl_status.log" 2>&1

echo [INFO] Listener start/status completed.
echo [INFO] Check logs:
echo [INFO]   %LOG_DIR%\firewall.log
echo [INFO]   %LOG_DIR%\lsnrctl_start.log
echo [INFO]   %LOG_DIR%\lsnrctl_status.log
echo.
echo [INFO] Press any key to exit...
pause >nul

endlocal
