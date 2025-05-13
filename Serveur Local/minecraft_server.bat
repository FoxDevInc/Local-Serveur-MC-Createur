@echo off
title Auto-Hébergeur Minecraft avec IP Personnalisée
color 0a
mode con: cols=80 lines=25

:menu
cls
echo.
echo  ==============================
echo    AUTO-HEBERGEUR MINECRAFT
echo    FoxDevInc - 2025 v.1.0
echo  ==============================
echo.
echo  1. Installer/Configurer le serveur
echo  2. Demarrer le serveur
echo  3. Changer l'IP du serveur
echo  4. Quitter
echo.
set /p choix="Choisissez une option [1-4]: "

if "%choix%"=="1" goto install
if "%choix%"=="2" goto start
if "%choix%"=="3" goto changeip
if "%choix%"=="4" exit
goto menu

:install
cls
echo Installation du serveur Minecraft...
echo.

if not exist "server" mkdir server
cd server

if exist "eula.txt" del eula.txt
if exist "server.properties" del server.properties

echo Téléchargement du serveur Minecraft...
echo.
curl -o server.jar https://launcher.mojang.com/v1/objects/886945bfb2b978778c3a0288fd7fab09d315b25f/server.jar

echo.
echo Configuration initiale...
echo.
java -Xmx1024M -Xms1024M -jar server.jar nogui

echo eula=true > eula.txt

:changeip
cls
echo Configuration de l'IP du serveur...
echo.
set /p ip="Entrez l'IP que vous voulez utiliser (laisser vide pour localhost): "
if "%ip%"=="" set ip=0.0.0.0

echo server-ip=%ip% >> server.properties
echo.
echo IP configurée sur: %ip%
pause
goto menu

:start
cls
echo Démarrage du serveur Minecraft...
echo.
cd server

set /a xmx=0
:memory
set /p xmx="Quantité de mémoire RAM à allouer (en Mo, 1024 minimum): "
if %xmx% LSS 1024 (
    echo La valeur doit être au moins 1024 Mo
    goto memory
)

java -Xmx%xmx%M -Xms1024M -jar server.jar nogui
pause
goto menu