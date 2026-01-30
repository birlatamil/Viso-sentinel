# FaceGuard Testing Guide

## Test Email
**birlatamil860@gmail.com**

## Testing Workflow

### Step 1: Start the Application

1. **Start Backend:**
   - Run `start_backend.bat` or:
   ```powershell
   cd backend
   .\venv\Scripts\Activate.ps1
   uvicorn main:app --reload
   ```

2. **Start Frontend:**
   - Run `start_frontend.bat` or:
   ```powershell
   cd frontend
   npm run dev
   ```

### Step 2: Register as Identity Owner

1. Go to http://localhost:3000
2. Click **"Identity Owner"**
3. Fill in the form:
   - **Name:** Your Name (or "Test User")
   - **Email:** birlatamil860@gmail.com
   - **Face Image:** Upload a clear photo of your face
4. Click **"Register Face"**
5. **Save the Identity ID** that appears (you'll need it later)

### Step 3: Upload Content as Creator

1. Go to http://localhost:3000
2. Click **"Content Creator"**
3. Fill in:
   - **Creator ID:** Any ID (e.g., "creator-001")
   - **AI-Generated Content:** Upload an image containing faces
4. Click **"Upload Content"**
5. The system will:
   - Detect faces in the image
   - Match against registered identities
   - Create consent requests if matches found

### Step 4: Approve/Reject Consent

1. Go back to **Identity Owner Dashboard**
2. Click **"Consent Requests"** tab
3. Enter your **Identity ID** (from Step 2)
4. Click **"Load Requests"**
5. You'll see pending consent requests
6. Click **"Approve"** or **"Reject"**

### Step 5: Download Approved Content

1. Go back to **Creator Dashboard**
2. Click **"Check Verification Status"**
3. If approved, you'll see:
   - Status: **Approved**
   - Consent Token
   - Download button

## API Testing (Alternative)

You can also test directly via API:

### Register Face
```powershell
$formData = @{
    name = "Test User"
    email = "birlatamil860@gmail.com"
    image = Get-Item "path\to\your\face.jpg"
}
Invoke-RestMethod -Uri "http://localhost:8000/api/register-face" -Method Post -Form $formData
```

### Upload Content
```powershell
$formData = @{
    creator_id = "test-creator"
    image = Get-Item "path\to\ai-generated-content.jpg"
}
Invoke-RestMethod -Uri "http://localhost:8000/api/upload-content" -Method Post -Form $formData
```

### Check Consent Requests
```powershell
$identityId = "YOUR_IDENTITY_ID"
Invoke-RestMethod -Uri "http://localhost:8000/api/consent-requests?identity_owner_id=$identityId"
```

## Expected Results

✅ **Face Registration:**
- Returns Identity ID
- Stores face embedding (not the image)

✅ **Content Upload:**
- Detects faces in image
- Matches against registered identities
- Creates consent requests for matches

✅ **Consent Approval:**
- Generates consent token
- Updates content status to "approved"
- Creator can download content

✅ **Consent Rejection:**
- Updates content status to "rejected"
- Creator cannot download

## Troubleshooting

- **No faces detected:** Ensure image has clear, visible faces
- **No matches found:** Make sure you registered a face first
- **Module errors:** Run `fix_frontend.bat`
- **Backend not starting:** Check if port 8000 is available

## Test Scenarios

1. **Happy Path:**
   - Register face → Upload content → Approve → Download

2. **Rejection Path:**
   - Register face → Upload content → Reject → Status shows rejected

3. **No Match:**
   - Upload content with faces not registered → No consent requests created

4. **Multiple Faces:**
   - Upload content with multiple faces → Creates requests for each match

