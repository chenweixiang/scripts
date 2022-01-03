@echo off
set option0=Please input your choice:
set option1=  1: enable virtual WiFi
set option2=  2: disable virtual WiFi
set option3=  3: show virtual WiFi status
set option4=  4: quit from this script
set option5=Your choice: 

:begin
echo %option0%
echo %option1%
echo %option2%
echo %option3%
echo %option4%
set /p inparam=%option5%

if "%inparam%"=="1" goto enableVirtualWiFi
if "%inparam%"=="2" goto disableVirtualWiFi
if "%inparam%"=="3" goto showVirtualWiFi
if "%inparam%"=="4" goto quitFromScript
goto begin

:enableVirtualWiFi
echo ===============================
echo === Enable virtual WiFi
echo ===============================
netsh wlan set hostednetwork mode=allow
netsh wlan set hostednetwork ssid=MyWiFiPort key=alex123456
netsh wlan start hostednetwork
goto showVirtualWiFi

:disableVirtualWiFi
echo ===============================
echo === Disable virtual WiFi
echo ===============================
netsh wlan set hostednetwork mode=disallow
goto showVirtualWiFi

:showVirtualWiFi
echo ===============================
echo === Show virtual WiFi status
echo ===============================
netsh wlan show hostednetwork
goto quitFromScript

:quitFromScript
echo ===============================
echo === Quit from this script
echo ===============================
pause
