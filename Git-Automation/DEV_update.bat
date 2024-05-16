@echo off
REM Change to the directory where your Git repository is located
cd ..\

git fetch --all
git reset --hard origin/main