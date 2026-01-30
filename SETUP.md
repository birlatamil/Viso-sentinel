# FaceGuard Setup Guide

## Prerequisites

- Python 3.8+ 
- Node.js 18+ and npm
- (Optional) CUDA-capable GPU for faster face processing

## Backend Setup

1. **Navigate to backend directory:**
   ```bash
   cd backend
   ```

2. **Create virtual environment:**
   ```bash
   python -m venv venv
   ```

3. **Activate virtual environment:**
   - Windows: `venv\Scripts\activate`
   - Linux/Mac: `source venv/bin/activate`

4. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

5. **Note on InsightFace:**
   - InsightFace will automatically download the `buffalo_l` model on first run
   - This may take a few minutes and requires internet connection
   - Model files are cached for subsequent runs

6. **Run the backend server:**
   ```bash
   uvicorn main:app --reload
   ```

   The API will be available at `http://localhost:8000`
   API documentation at `http://localhost:8000/docs`

## Frontend Setup

1. **Navigate to frontend directory:**
   ```bash
   cd frontend
   ```

2. **Install dependencies:**
   ```bash
   npm install
   ```

3. **Run the development server:**
   ```bash
   npm run dev
   ```

   The frontend will be available at `http://localhost:3000`

## Usage Flow

### For Identity Owners:

1. Go to `/identity-owner` dashboard
2. Register your face by providing:
   - Name
   - Email
   - Face image
3. Save your Identity ID
4. View consent requests in the "Consent Requests" tab
5. Approve or reject requests

### For Content Creators:

1. Go to `/creator` dashboard
2. Enter your Creator ID
3. Upload AI-generated content containing faces
4. System automatically detects faces and matches with registered identities
5. Check verification status
6. Download content only if approved

## API Endpoints

### Identity Owner
- `POST /api/register-face` - Register face
- `GET /api/consent-requests?identity_owner_id={id}` - Get consent requests
- `POST /api/approve-consent` - Approve consent
- `POST /api/reject-consent` - Reject consent

### Content Creator
- `POST /api/upload-content` - Upload content
- `GET /api/verify-status/{content_id}` - Check status
- `GET /api/download-content/{content_id}` - Download approved content

### General
- `GET /api/validate-token/{token}` - Validate consent token
- `GET /health` - Health check

## Database

- **MVP**: SQLite (automatically created in `backend/faceguard.db`)
- **Production**: PostgreSQL + pgvector (update `DATABASE_URL` in `.env`)

## Troubleshooting

### InsightFace Model Download Issues
- Ensure internet connection on first run
- Model files are cached in `~/.insightface/models/`
- For offline use, manually download `buffalo_l` model

### CORS Issues
- Ensure backend CORS settings include your frontend URL
- Default: `http://localhost:3000`

### Face Detection Not Working
- Ensure images contain clear, visible faces
- Check image format (JPEG, PNG supported)
- Verify InsightFace model loaded successfully

## Production Deployment

1. **Backend:**
   - Use PostgreSQL instead of SQLite
   - Set up proper environment variables
   - Use production ASGI server (e.g., Gunicorn + Uvicorn)

2. **Frontend:**
   - Build: `npm run build`
   - Serve: `npm start`
   - Or deploy to Vercel/Netlify

3. **Storage:**
   - Use cloud storage (S3, Azure Blob) for uploaded images
   - Implement cleanup jobs for temporary files

4. **Security:**
   - Add authentication/authorization
   - Use HTTPS
   - Implement rate limiting
   - Add input validation

