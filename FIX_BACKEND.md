# Fix Backend - InsightFace Installation Issue

## Problem
```
ModuleNotFoundError: No module named 'insightface'
```

## Solution

### Option 1: Use the Installation Script (Recommended)

Run the installation script:
```powershell
cd backend
.\install_dependencies.bat
```

Or PowerShell version:
```powershell
cd backend
powershell -ExecutionPolicy Bypass -File install_dependencies.ps1
```

### Option 2: Manual Installation

1. **Activate virtual environment:**
   ```powershell
   cd backend
   .\venv\Scripts\Activate.ps1
   ```

2. **Upgrade pip and install base dependencies:**
   ```powershell
   python -m pip install --upgrade pip setuptools wheel
   pip install numpy==1.24.3
   pip install opencv-python-headless==4.8.1.78
   pip install onnxruntime==1.16.3
   ```

3. **Install InsightFace:**
   ```powershell
   pip install insightface==0.7.3
   ```

4. **Install remaining dependencies:**
   ```powershell
   pip install -r requirements.txt
   ```

### Option 3: Alternative InsightFace Installation

If the above doesn't work, try installing from source:

```powershell
pip install git+https://github.com/deepinsight/insightface.git
```

Or install specific version:
```powershell
pip install insightface==0.7.3 --no-cache-dir
```

### Verify Installation

Check if InsightFace is installed:
```powershell
cd backend
.\venv\Scripts\python.exe -c "import insightface; print('InsightFace installed successfully')"
```

Or run the dependency checker:
```powershell
.\venv\Scripts\python.exe check_dependencies.py
```

### Common Issues

1. **Visual C++ Redistributable missing:**
   - Download and install: https://aka.ms/vs/17/release/vc_redist.x64.exe

2. **ONNX Runtime issues:**
   - Try: `pip install onnxruntime==1.16.3 --no-cache-dir`

3. **OpenCV issues:**
   - Try: `pip install opencv-python-headless --upgrade`

4. **Permission errors:**
   - Run PowerShell as Administrator
   - Or use: `pip install --user insightface`

### After Installation

Once installed, start the backend:
```powershell
cd backend
.\venv\Scripts\Activate.ps1
uvicorn main:app --reload
```

Or use the startup script:
```powershell
.\start_backend.bat
```

## Still Having Issues?

1. Check Python version (should be 3.8+):
   ```powershell
   python --version
   ```

2. Verify virtual environment is activated:
   ```powershell
   where python
   # Should show: ...\backend\venv\Scripts\python.exe
   ```

3. Recreate virtual environment:
   ```powershell
   cd backend
   Remove-Item -Recurse -Force venv
   python -m venv venv
   .\venv\Scripts\Activate.ps1
   pip install -r requirements.txt
   ```

