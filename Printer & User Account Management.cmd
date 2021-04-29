@echo off

title Printer - Account - network Management
:Menu_Start

cls
echo. 
echo Printer - Account - network Management
echo.
echo.
echo 1 - Account Management and network
echo.
echo 2 - Printer Tools
echo.
echo 3 - Software Activation
echo.
Choice /N /C:123 /M "Choose an option (1-3) "
goto menu-%ErrorLevel%

::===============================================================================
::===============================================================================
::===============================================================================
::===============================================================================

:Menu-1 USRACCMNGMT

:USRACCMNGMT_Start
::Rev6 Updated 07/31/19 2:14PM [CL]
cls
echo.
echo User Management + Drive Map
echo.
echo Your Credentials:
echo.
echo ID: %username%
echo T#: %computername%
echo Domain: %userdomain%
echo Logon: %LOGONSERVER%
echo. 
echo. 
echo.
echo Manage user account info such as passwords and groups.
echo.
echo.
echo.
echo 1 - Get username info on the domain: %userdomain%
echo.
echo 2 - Change/reset a users password.
echo.
echo 3 - Map network drive by hostname. (Example: %computername%)
echo.
echo 4 - Ping Host
echo.
echo 5 - Lookup Windows OS Date.
echo.
echo 6 - Exit to Main Menu
echo.
echo.
choice /n /c:123456 /M "Choose an option (1-6) "
goto USRACCMNGMT-%ErrorLevel%

:: =================USER INFO=======================

:USRACCMNGMT-1 USER_INFO
cls
echo.
echo.
echo This will show a users info on the current domain. (Example: %username%)
echo.
echo.
set /p user=Enter username:
net user %user% /domain
echo.
echo Finished!
pause
cls
goto USRACCMNGMT_Start

:: =================PASS MANAGEMENT=================

:USRACCMNGMT-2 CHNG_PASS
cls
echo.
echo. 
echo This change/reset a users password. (Example: %username%)
echo.
echo.
set /p user=Enter username:
set /p pass=Enter new password:
set /p passchng=User must reset password at first login? Yes/No:
net user %user% %pass% /logonpasswordchg:%passchng% /domain
echo.
echo.
echo %user%'s password was set to: %pass%
echo.
echo Finished!
pause
cls
goto USRACCMNGMT_Start

:: =================MAP netWORK DRIVE==============

:USRACCMNGMT-3 MAP_HDD
cls
echo. 
echo.
echo This will map you to a network drive by hostname. (Example: %computername%)
echo.
echo.
set /p host=Enter hostname:
set /p school=Enter Location (ex. MCE):
Explorer \\%host%.%Location%.PUT_DOMAIN_HERE\C$
echo.
echo Finished!
pause
cls
goto USRACCMNGMT_Start

:: =================Ping Host==========

:USRACCMNGMT-4 PING_HOST
cls
echo.
echo.
echo Ping Host name  (Ex.%computername%)
echo.
echo.
set /p piing=Enter host name/IP Address:
ping %piing%
pause
cls
goto USRACCMNGMT_Start

::===============Look Up OS Date==================

:USRACCMNGMT-5 OSDate
cls
echo.
echo. 
echo Looking up Windows OS install date.
echo.
echo.
systeminfo|find /i "original"
echo.
echo Finished!
pause
cls
goto USRACCMNGMT_Start

::===============Quit to Main Menu=================
:USRACCMNGMT-6 Exit2Menu
goto Menu_Start

::===============================================================================
::===============================================================================
::===============================================================================
::===============================================================================

:menu-2 PRINTER

cls
:Printer_Start
echo.
echo Printer Driver Utility
echo.
echo.
echo 1 - Delete Corrupted HP Printer Drivers x64
echo.
echo 2 - Start Printer Spooler Service
echo.
echo 3 - Stop Printer Spooler Service
echo.
echo 4 - Start Remote Procedure Call (RPC) Locator
echo.
echo 5 - Stop Remote Procedure Call (RPC) Locator
echo.
echo 6 - Exit to Main Menu
echo.
echo.
choice /n /c:123456 /M "Choose an option (1-6) "
goto Printer-%ErrorLevel%

::============Delete Corrupted HP Drivers x64============

:Printer-1 DELDRIV64
cls
rem if exist PrintIsolationHost.exe taskkill /F /IM PrintIsolationHost.exe
echo.
net stop Spooler
echo Removing Files...
pushd C:\Windows\System32\spool\drivers\x64\3
If exist HP* del /q HP*
echo.
net start Spooler
echo.
echo Finished!
pause
cls
goto Printer_Start

::===============Stop Print Spooler=================

:Printer-2 STARTSPOOLER
cls
echo.
net start spooler
echo.
echo Finished!
pause
cls
goto Printer_Start

::===============Start Print Spooler================

:Printer-3 STOPSPOOLER
cls
echo.
net stop spooler
echo.
echo Finished!
pause
cls
goto Printer_Start

::======Start Remote Procedure Call (RPC) Locator=======

:Printer-4 STARTRPC
cls
echo.
net start RpcLocator
echo.
echo Finished!
pause
cls
goto Printer_Start

::======Stop Remote Procedure Call (RPC) Locator=======

:Printer-5 STOPRPC
cls
echo.
net stop RpcLocator
echo.
echo Finished!
pause
cls
goto Printer_Start

::===============Quit to Main Menu================

:Printer-6 Exit2Menu
goto Menu_Start
cls

::===============================================================================
::===============================================================================
::===============================================================================
::===============================================================================

:menu-3 Activation

cls
:Activation_Start
::Rev3 [CL]
echo.
echo Software Activation
echo.
echo.
echo 1 - Activate Windows 7
echo.
echo 2 - Activate Office 2016
echo.
echo 3 - Exit to Main Menu
echo.
echo.
choice /n /c:123 /M "Choose an option (1-3) "
goto Activation-%ErrorLevel%

::===============Activate Windows 7=================

:Activation-1 ACT0FF13
cls
echo.
echo.
echo Activating Windows 7
echo.
slmgr -ipk PUT_WINDOWS_KEY_HERE
slmgr -ato
echo.
echo Finished!
pause
cls
goto Activation_Start

::===============Activate Office 2013===============

:Activation-2 ACTWIN7
cls
echo.
echo.
echo Activating Office 2016
echo.
cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /inpkey:PUT_OFFICE_KEY_HERE
cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /act
echo.
echo Finished!
pause
cls
goto Activation_Start

::===============Quit to Main Menu==================

:Activation-3 Exit2Menu
goto Menu_Start
cls

::This is the end of the batch! Thank you! [CL]
::===============================================================================
::===============================================================================