# FaceGuard Startup Script
Write-Host "Starting FaceGuard Application..." -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan

# Check if backend is running
$backendRunning = Get-NetTCPConnection -LocalPort 8000 -ErrorAction SilentlyContinue
if ($backendRunning) {
    Write-Host "Backend is already running on port 8000" -ForegroundColor Yellow
} else {
    Write-Host "`nStarting Backend Server..." -ForegroundColor Green
    Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PSScriptRoot\backend'; .\venv\Scripts\Activate.ps1; uvicorn main:app --host 0.0.0.0 --port 8000"
    Start-Sleep -Seconds 3
    Write-Host "Backend should be running at http://localhost:8000" -ForegroundColor Green
}

# Check if frontend is running
$frontendRunning = Get-NetTCPConnection -LocalPort 3000 -ErrorAction SilentlyContinue
if ($frontendRunning) {
    Write-Host "Frontend is already running on port 3000" -ForegroundColor Yellow
} else {
    Write-Host "`nStarting Frontend Server..." -ForegroundColor Green
    Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PSScriptRoot\frontend'; npm run dev"
    Start-Sleep -Seconds 3
    Write-Host "Frontend should be running at http://localhost:3000" -ForegroundColor Green
}

Write-Host "`n=================================" -ForegroundColor Cyan
Write-Host "Application Status:" -ForegroundColor Cyan
Write-Host "- Backend API: http://localhost:8000" -ForegroundColor White
Write-Host "- Backend Docs: http://localhost:8000/docs" -ForegroundColor White
Write-Host "- Frontend: http://localhost:3000" -ForegroundColor White
Write-Host "`nPress any key to check status..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

# Check status
Write-Host "`nChecking application status..." -ForegroundColor Cyan
try {
    $backendStatus = Invoke-WebRequest -Uri "http://localhost:8000/health" -UseBasicParsing -TimeoutSec 2
    Write-Host "✓ Backend is responding" -ForegroundColor Green
} catch {
    Write-Host "✗ Backend is not responding" -ForegroundColor Red
}

try {
    $frontendStatus = Invoke-WebRequest -Uri "http://localhost:3000" -UseBasicParsing -TimeoutSec 2
    Write-Host "✓ Frontend is responding" -ForegroundColor Green
} catch {
    Write-Host "✗ Frontend is not responding" -ForegroundColor Red
}

