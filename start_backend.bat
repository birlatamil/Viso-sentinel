@echo off
echo Starting FaceGuard Backend...
cd backend
call venv\Scripts\activate.bat
echo.
echo Backend starting on http://localhost:8000
echo API docs available at http://localhost:8000/docs
echo.
uvicorn main:app --reload --host 0.0.0.0 --port 8000
pause

