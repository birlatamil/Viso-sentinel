# Fix: InsightFace API Error

## Problem
```
RuntimeError: FaceAnalysis.__init__() got an unexpected keyword argument 'providers'
```

## Solution Applied

The InsightFace API has changed. The `providers` argument is no longer accepted in the `FaceAnalysis` constructor.

### Changes Made

1. **Removed `providers` argument** from `FaceAnalysis` initialization
2. **Changed `ctx_id` from 0 to -1** for CPU execution (0 is for GPU)
3. **Added lazy initialization** to avoid startup errors

### Updated Code

**Before:**
```python
self.app = insightface.app.FaceAnalysis(
    name='buffalo_l',
    providers=['CPUExecutionProvider']
)
self.app.prepare(ctx_id=0, det_size=(640, 640))
```

**After:**
```python
self.app = insightface.app.FaceAnalysis(name='buffalo_l')
self.app.prepare(ctx_id=-1, det_size=(640, 640))
```

### Key Points

- `providers` is handled internally by onnxruntime
- `ctx_id=-1` means CPU execution
- `ctx_id=0+` means GPU execution (if CUDA available)
- Lazy initialization prevents errors at import time

## Testing

After the fix, the backend should start without errors:

```powershell
cd backend
.\venv\Scripts\Activate.ps1
uvicorn main:app --reload
```

The server should start successfully and be available at `http://localhost:8000`

