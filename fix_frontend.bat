@echo off
echo Fixing Frontend Issues...
echo.
cd frontend

echo Removing .next folder...
if exist .next rmdir /s /q .next

echo Removing node_modules...
if exist node_modules rmdir /s /q node_modules

echo Clearing npm cache...
call npm cache clean --force

echo Installing dependencies...
call npm install

echo.
echo Frontend fixed! Now run start_frontend.bat
pause

