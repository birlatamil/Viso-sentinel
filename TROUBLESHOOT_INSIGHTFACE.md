# Troubleshooting InsightFace Model Download Error

## Error Message
```
Failed to initialize InsightFace model. Ensure internet connection for first-time model download. Error:
```

## Common Causes & Solutions

### 1. No Internet Connection
**Problem:** InsightFace needs to download the `buffalo_l` model on first use (~100MB).

**Solution:**
- Ensure you have an active internet connection
- The model will be cached after first download
- Check: `ping google.com` or `ping github.com`

### 2. Firewall/Proxy Blocking Download
**Problem:** Corporate firewall or proxy blocking model download.

**Solution:**
- Configure proxy settings if needed
- Whitelist GitHub and model download URLs
- Try downloading manually from: https://github.com/deepinsight/insightface

### 3. Model Cache Directory Issues
**Problem:** Cannot write to model cache directory.

**Solution:**
- Check permissions on: `~/.insightface/models/` (Linux/Mac) or `%USERPROFILE%\.insightface\models\` (Windows)
- Ensure sufficient disk space (need ~500MB free)
- Try running as administrator if permission issues

### 4. Network Timeout
**Problem:** Download times out due to slow connection.

**Solution:**
- Wait longer (first download can take 5-10 minutes on slow connections)
- Check your internet speed
- Try again later

## Test InsightFace Installation

Run the test script to diagnose the issue:

```powershell
cd backend
.\venv\Scripts\Activate.ps1
python test_insightface.py
```

This will:
1. Test InsightFace import
2. Test model initialization
3. Test model download
4. Show detailed error messages

## Manual Model Download (Alternative)

If automatic download fails, you can manually download the model:

1. **Find model cache directory:**
   ```powershell
   python -c "import insightface; print(insightface.model_zoo.get_model_file('buffalo_l'))"
   ```

2. **Download model files manually:**
   - Visit: https://github.com/deepinsight/insightface/tree/master/python-package
   - Download `buffalo_l` model files
   - Place in cache directory

## Quick Fix: Pre-download Model

You can pre-download the model before starting the server:

```powershell
cd backend
.\venv\Scripts\Activate.ps1
python -c "import insightface; app = insightface.app.FaceAnalysis(name='buffalo_l'); app.prepare(ctx_id=-1)"
```

This will download the model and cache it for future use.

## Check Server Logs

The backend now logs detailed error messages. Check the console output when the error occurs to see the full traceback.

## Still Having Issues?

1. **Check backend console** for full error message
2. **Run test script:** `python test_insightface.py`
3. **Verify internet:** Try accessing https://github.com
4. **Check disk space:** Ensure at least 1GB free
5. **Check permissions:** Ensure write access to user directory

