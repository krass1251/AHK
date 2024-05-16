@echo off
REM Change to the directory where your Git repository is located
cd C:\krass\personal\AHK

REM add files 
git add .

REM Perform git commit with the message "upd BS"
git commit -m "upd BS"

REM Push the commit to the remote repository
git push -f

REM Reset the last commit, keeping the changes in the working directory
git reset --soft HEAD~1