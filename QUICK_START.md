# Quick Start Guide - FaceGuard

## Step 1: Start Backend

Open a PowerShell terminal and run:

```powershell
cd backend
.\venv\Scripts\Activate.ps1
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

The backend will be available at:
- API: http://localhost:8000
- Docs: http://localhost:8000/docs

## Step 2: Fix Frontend (if needed)

If you encounter the `no-fallback-error.external.js` error:

```powershell
cd frontend
Remove-Item -Recurse -Force .next -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force node_modules -ErrorAction SilentlyContinue
npm cache clean --force
npm install
```

## Step 3: Start Frontend

Open a NEW PowerShell terminal and run:

```powershell
cd frontend
npm run dev
```

The frontend will be available at:
- http://localhost:3000

## Troubleshooting

### Backend Issues

1. **Module not found errors:**
   ```powershell
   cd backend
   .\venv\Scripts\Activate.ps1
   pip install -r requirements.txt
   ```

2. **Database errors:**
   ```powershell
   cd backend
   .\venv\Scripts\python.exe -c "from database import init_db; init_db()"
   ```

### Frontend Issues

1. **Next.js module errors:**
   - Delete `.next` folder
   - Delete `node_modules` folder
   - Run `npm install` again

2. **Port already in use:**
   - Change port: `npm run dev -- -p 3001`
   - Or kill process: `Get-Process -Id (Get-NetTCPConnection -LocalPort 3000).OwningProcess | Stop-Process`

## Verify Installation

Run the status check script:

```powershell
powershell -ExecutionPolicy Bypass -File check_status.ps1
```

## Manual Testing

1. **Test Backend:**
   ```powershell
   curl http://localhost:8000/health
   ```

2. **Test Frontend:**
   Open browser to http://localhost:3000

3. **Test API:**
   Open browser to http://localhost:8000/docs

