# FaceGuard Status Check Script
Write-Host "`nFaceGuard Application Status Check" -ForegroundColor Cyan
Write-Host "===================================`n" -ForegroundColor Cyan

# Check Backend
Write-Host "Backend Status:" -ForegroundColor Yellow
$backendPort = 8000
$backendConn = Get-NetTCPConnection -LocalPort $backendPort -ErrorAction SilentlyContinue

if ($backendConn) {
    Write-Host "  ✓ Backend is running on port $backendPort" -ForegroundColor Green
    try {
        $response = Invoke-WebRequest -Uri "http://localhost:$backendPort/health" -UseBasicParsing -TimeoutSec 2
        Write-Host "  ✓ Backend API is responding" -ForegroundColor Green
        Write-Host "  ✓ API Docs: http://localhost:$backendPort/docs" -ForegroundColor Cyan
    } catch {
        Write-Host "  ✗ Backend API is not responding" -ForegroundColor Red
    }
} else {
    Write-Host "  ✗ Backend is not running" -ForegroundColor Red
    Write-Host "    Start with: cd backend; .\venv\Scripts\Activate.ps1; uvicorn main:app --reload" -ForegroundColor Gray
}

Write-Host ""

# Check Frontend
Write-Host "Frontend Status:" -ForegroundColor Yellow
$frontendPort = 3000
$frontendConn = Get-NetTCPConnection -LocalPort $frontendPort -ErrorAction SilentlyContinue

if ($frontendConn) {
    Write-Host "  ✓ Frontend is running on port $frontendPort" -ForegroundColor Green
    try {
        $response = Invoke-WebRequest -Uri "http://localhost:$frontendPort" -UseBasicParsing -TimeoutSec 2
        Write-Host "  ✓ Frontend is responding" -ForegroundColor Green
    } catch {
        Write-Host "  ✗ Frontend is not responding" -ForegroundColor Red
    }
} else {
    Write-Host "  ✗ Frontend is not running" -ForegroundColor Red
    Write-Host "    Start with: cd frontend; npm run dev" -ForegroundColor Gray
}

Write-Host ""

# Check Dependencies
Write-Host "Dependency Check:" -ForegroundColor Yellow

# Backend
$backendPath = Join-Path $PSScriptRoot "backend"
if (Test-Path (Join-Path $backendPath "venv")) {
    Write-Host "  ✓ Backend virtual environment exists" -ForegroundColor Green
} else {
    Write-Host "  ✗ Backend virtual environment not found" -ForegroundColor Red
}

# Frontend
$frontendPath = Join-Path $PSScriptRoot "frontend"
if (Test-Path (Join-Path $frontendPath "node_modules")) {
    Write-Host "  ✓ Frontend node_modules exists" -ForegroundColor Green
} else {
    Write-Host "  ✗ Frontend node_modules not found" -ForegroundColor Red
    Write-Host "    Run: cd frontend; npm install" -ForegroundColor Gray
}

Write-Host ""

# Check Database
$dbPath = Join-Path $backendPath "faceguard.db"
if (Test-Path $dbPath) {
    Write-Host "  ✓ Database file exists" -ForegroundColor Green
} else {
    Write-Host "  ⚠ Database will be created on first run" -ForegroundColor Yellow
}

Write-Host "`n===================================`n" -ForegroundColor Cyan

