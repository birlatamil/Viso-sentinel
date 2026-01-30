# FaceGuard - AI Consent Verification System

**Purpose**: Identify real human faces inside AI-generated content and enforce consent-based usage.

## Architecture Overview

### 🧠 AI & Computer Vision Layer
- **InsightFace**: High-accuracy facial embeddings
- **RetinaFace**: Face detection (via InsightFace pipeline)
- **Cosine Similarity**: Matching on embedding vectors
- **Threshold-based**: Confidence scoring

### ⚙️ Backend & Consent Engine
- **FastAPI**: Lightweight, async REST APIs
- **Consent Engine**: Face match → triggers consent workflow
- **Token Generation**: UUID-based consent tokens
- **Status Tracking**: Pending / Approved / Rejected

### 🗄️ Data & Storage Layer
- **Vector Database**: SQLite + pgvector (PostgreSQL for production)
- **Stored Data**: Face embeddings (not images), consent status, content hash + token
- **Media Storage**: Temporary object storage (local)

### 🖥️ Frontend (Dual Dashboard UI)
- **Next.js + React**: Modern, scalable frontend
- **Identity Owner Dashboard**: Register face, view consent requests, approve/reject
- **Creator Dashboard**: Upload content, view verification status, download approved content

### 🔐 Security & Ethics Layer
- No raw face image storage (embeddings only)
- Human-in-the-loop approval
- Explainable confidence scoring

## Quick Start

### Backend Setup

```bash
cd backend
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt
uvicorn main:app --reload
```

### Frontend Setup

```bash
cd frontend
npm install
npm run dev
```

## API Endpoints

- `POST /api/register-face` - Register a face for an identity owner
- `POST /api/upload-content` - Upload AI-generated content for verification
- `GET /api/consent-requests` - Get consent requests for an identity owner
- `POST /api/approve-consent` - Approve a consent request
- `POST /api/reject-consent` - Reject a consent request
- `GET /api/verify-status/{content_id}` - Check verification status
- `GET /api/validate-token/{token}` - Validate a consent token

## Project Structure

```
.
├── backend/
│   ├── main.py              # FastAPI application
│   ├── models.py            # Database models
│   ├── face_service.py      # InsightFace integration
│   ├── consent_engine.py    # Consent workflow logic
│   ├── database.py          # Database setup
│   └── requirements.txt     # Python dependencies
├── frontend/
│   ├── app/                 # Next.js app directory
│   ├── components/          # React components
│   └── package.json         # Node dependencies
└── README.md
```

## Future Scope

- Decentralized Identity (DID)
- Blockchain-based consent tokens
- Video & real-time scanning
- Platform-native plugins

**"Our architecture is API-first and decentralized-ready, but today we focus on proving consent enforcement works."**

