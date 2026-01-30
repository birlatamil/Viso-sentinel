# Solution: Visual C++ Build Tools Required

## The Problem

InsightFace requires compilation of Cython extensions, which needs Microsoft Visual C++ 14.0 or greater.

## Quick Solution

### Step 1: Install Visual C++ Build Tools

1. **Download the installer:**
   - Direct link: https://aka.ms/vs/17/release/vs_buildtools.exe
   - Or visit: https://visualstudio.microsoft.com/visual-cpp-build-tools/

2. **Run the installer and select:**
   - ✅ **C++ build tools** workload
   - ✅ **MSVC v143 - VS 2022 C++ x64/x86 build tools** (or latest)
   - ✅ **Windows 10/11 SDK** (latest version)

3. **Install** (this will download ~3-6 GB)

4. **Restart your terminal/PowerShell**

### Step 2: Install InsightFace

After installing Visual C++ Build Tools:

```powershell
cd backend
.\venv\Scripts\Activate.ps1
pip install insightface==0.7.3
```

### Step 3: Verify Installation

```powershell
python -c "import insightface; print('Success!')"
```

## Alternative: Use Pre-built Package

If you can't install Visual C++ Build Tools, try:

```powershell
pip install --only-binary :all: insightface
```

Note: This may not work if no pre-built wheels are available for your Python version.

## Check Your Setup

Run the checker script:

```powershell
cd backend
python check_visual_cpp.py
```

## After Installation

Once InsightFace is installed, start the backend:

```powershell
cd backend
.\venv\Scripts\Activate.ps1
uvicorn main:app --reload
```

## Still Having Issues?

If you continue to have problems:

1. **Make sure you restarted your terminal** after installing Visual C++ Build Tools
2. **Check Python version:** Should be 3.8-3.11 (Python 3.12+ may have issues)
3. **Try upgrading pip and setuptools:**
   ```powershell
   python -m pip install --upgrade pip setuptools wheel
   ```
4. **Use the workaround script:**
   ```powershell
   cd backend
   .\install_with_workaround.bat
   ```

## Why This Is Needed

InsightFace contains Cython code (Python code compiled to C) that needs to be compiled for your system. On Windows, this requires Microsoft's C++ compiler.

