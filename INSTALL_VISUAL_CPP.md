# Fix: Microsoft Visual C++ Build Tools Required

## Problem
InsightFace installation fails with:
```
error: Microsoft Visual C++ 14.0 or greater is required.
```

## Solution Options

### Option 1: Install Visual C++ Build Tools (Recommended)

1. **Download Microsoft C++ Build Tools:**
   - Visit: https://visualstudio.microsoft.com/visual-cpp-build-tools/
   - Or direct download: https://aka.ms/vs/17/release/vs_buildtools.exe

2. **Install:**
   - Run the installer
   - Select "C++ build tools" workload
   - Make sure "MSVC v143 - VS 2022 C++ x64/x86 build tools" is checked
   - Install (this will take several GB of space)

3. **After installation, restart your terminal and try again:**
   ```powershell
   cd backend
   .\venv\Scripts\Activate.ps1
   pip install insightface==0.7.3
   ```

### Option 2: Use Pre-built Wheel (If Available)

Try installing from a pre-built wheel:
```powershell
pip install --only-binary :all: insightface
```

### Option 3: Alternative - Use Face Recognition Library (Simpler)

If Visual C++ installation is not possible, we can switch to a simpler face recognition library that doesn't require compilation.

### Option 4: Use Conda (Easier Dependency Management)

Conda often has pre-built packages:
```powershell
conda install -c conda-forge insightface
```

## Quick Fix Script

I'll create a script that checks for Visual C++ and provides installation instructions.

