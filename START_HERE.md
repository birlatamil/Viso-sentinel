# 🚀 FaceGuard - Start Here

## Quick Start (Recommended)

### Option 1: Use the Startup Script

```powershell
powershell -ExecutionPolicy Bypass -File start_app.ps1
```

### Option 2: Manual Start

#### Terminal 1 - Backend:
```powershell
cd backend
.\venv\Scripts\Activate.ps1
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

#### Terminal 2 - Frontend:
```powershell
cd frontend
npm run dev
```

## If You Get Frontend Errors

The `no-fallback-error.external.js` error is fixed by:

1. **Clean and reinstall:**
   ```powershell
   cd frontend
   Remove-Item -Recurse -Force .next -ErrorAction SilentlyContinue
   Remove-Item -Recurse -Force node_modules -ErrorAction SilentlyContinue
   npm cache clean --force
   npm install
   npm run dev
   ```

2. **If still having issues, try:**
   ```powershell
   cd frontend
   npm install next@14.2.5 --save-exact
   npm run dev
   ```

## Verify Everything Works

1. **Backend Health Check:**
   - Open: http://localhost:8000/health
   - Should see: `{"status":"healthy"}`

2. **Backend API Docs:**
   - Open: http://localhost:8000/docs
   - Should see Swagger UI

3. **Frontend:**
   - Open: http://localhost:3000
   - Should see FaceGuard landing page

## Application URLs

- **Frontend:** http://localhost:3000
- **Backend API:** http://localhost:8000
- **API Documentation:** http://localhost:8000/docs
- **Health Check:** http://localhost:8000/health

## Next Steps

1. Go to http://localhost:3000
2. Click "Identity Owner" to register a face
3. Click "Content Creator" to upload content
4. Test the consent workflow!

## Need Help?

- Check `QUICK_START.md` for detailed troubleshooting
- Check `SETUP.md` for full setup instructions
- Check `ARCHITECTURE.md` for system overview

