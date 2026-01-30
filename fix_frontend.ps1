# Fix Frontend Issues Script
Write-Host "Fixing Frontend Issues..." -ForegroundColor Cyan

$frontendPath = Join-Path $PSScriptRoot "frontend"

if (Test-Path $frontendPath) {
    Set-Location $frontendPath
    
    Write-Host "1. Removing .next folder..." -ForegroundColor Yellow
    if (Test-Path .next) {
        Remove-Item -Recurse -Force .next
        Write-Host "   ✓ Removed" -ForegroundColor Green
    }
    
    Write-Host "2. Removing node_modules..." -ForegroundColor Yellow
    if (Test-Path node_modules) {
        Remove-Item -Recurse -Force node_modules
        Write-Host "   ✓ Removed" -ForegroundColor Green
    }
    
    Write-Host "3. Clearing npm cache..." -ForegroundColor Yellow
    npm cache clean --force
    Write-Host "   ✓ Cache cleared" -ForegroundColor Green
    
    Write-Host "4. Installing dependencies..." -ForegroundColor Yellow
    npm install
    Write-Host "   ✓ Dependencies installed" -ForegroundColor Green
    
    Write-Host "`n✅ Frontend setup complete!" -ForegroundColor Green
    Write-Host "Run 'npm run dev' to start the frontend" -ForegroundColor Cyan
} else {
    Write-Host "Frontend directory not found!" -ForegroundColor Red
}

