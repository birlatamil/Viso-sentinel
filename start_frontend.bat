@echo off
echo Starting FaceGuard Frontend...
cd frontend
echo.
echo If you see module errors, run: fix_frontend.bat first
echo.
echo Frontend starting on http://localhost:3000
echo.
call npm run dev
pause

