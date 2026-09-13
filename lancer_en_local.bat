@echo off
chcp 65001 >nul
title UADB Study Hub - Test local
color 0A

echo ============================================
echo    UADB Study Hub - Lancement en local
echo ============================================
echo.

REM --- Verifie que Python est installe ---
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERREUR] Python n'est pas installe ou pas reconnu.
    echo Telecharge-le sur https://www.python.org/downloads/
    echo Important : coche "Add Python to PATH" pendant l'installation.
    echo.
    pause
    exit /b 1
)

echo [OK] Python detecte.
echo.

REM --- Se place dans le dossier ou se trouve ce fichier .bat ---
cd /d "%~dp0"

REM --- Cree un environnement virtuel s'il n'existe pas deja ---
if not exist "venv\" (
    echo Premiere installation : creation de l'environnement...
    python -m venv venv
)

REM --- Active l'environnement virtuel ---
call venv\Scripts\activate.bat

REM --- Installe/met a jour les dependances ---
echo Installation des dependances (peut prendre 1-2 minutes la 1ere fois)...
pip install -r requirements.txt --quiet
echo.

REM --- Variable pour eviter tout conflit avec la config Render ---
set UADB_DB_PATH=

echo ============================================
echo Le site va demarrer.
echo Ouvre ton navigateur sur : http://localhost:5000
echo.
echo Pour arreter le site : ferme cette fenetre ou fais Ctrl+C
echo ============================================
echo.

python app.py

pause
