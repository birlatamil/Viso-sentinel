# FaceGuard Architecture

## System Overview

FaceGuard is an AI-powered consent verification system that identifies real human faces in AI-generated content and enforces consent-based usage through a privacy-first architecture.

## Architecture Layers

```
┌─────────────────────────────────────────────────────────────┐
│                    Frontend Layer                           │
│  ┌──────────────────────┐  ┌──────────────────────┐        │
│  │ Identity Owner       │  │ Content Creator      │        │
│  │ Dashboard            │  │ Dashboard            │        │
│  │ - Register Face      │  │ - Upload Content     │        │
│  │ - View Requests      │  │ - Check Status       │        │
│  │ - Approve/Reject     │  │ - Download Approved  │        │
│  └──────────────────────┘  └──────────────────────┘        │
│                    Next.js + React                          │
└─────────────────────────────────────────────────────────────┘
                            ↕ HTTP/REST
┌─────────────────────────────────────────────────────────────┐
│                    API Layer (FastAPI)                      │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │ Face         │  │ Consent      │  │ Content      │     │
│  │ Registration │  │ Management   │  │ Upload       │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
└─────────────────────────────────────────────────────────────┘
                            ↕
┌─────────────────────────────────────────────────────────────┐
│              AI & Computer Vision Layer                      │
│  ┌──────────────────────────────────────────────────────┐   │
│  │              InsightFace Service                      │   │
│  │  • RetinaFace Detection                              │   │
│  │  • Face Embedding Extraction (512-dim)               │   │
│  │  • Cosine Similarity Matching                         │   │
│  │  • Threshold-based Confidence Scoring                │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                            ↕
┌─────────────────────────────────────────────────────────────┐
│                    Consent Engine                            │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  • Face Match Detection                              │   │
│  │  • Consent Request Generation                        │   │
│  │  • Token Generation (UUID + Hash)                    │   │
│  │  • Status Management (Pending/Approved/Rejected)     │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                            ↕
┌─────────────────────────────────────────────────────────────┐
│                    Data & Storage Layer                      │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │ Identity     │  │ Content      │  │ Consent      │     │
│  │ Owners       │  │ Submissions  │  │ Requests     │     │
│  │ (Embeddings) │  │ (Metadata)   │  │ (Status)     │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
│              SQLite (MVP) / PostgreSQL (Production)         │
│              + pgvector for similarity search                │
└─────────────────────────────────────────────────────────────┘
```

## Data Flow

### 1. Face Registration Flow
```
Identity Owner → Upload Image → InsightFace → Extract Embedding 
→ Store Embedding (not image) → Return Identity ID
```

### 2. Content Upload Flow
```
Creator → Upload Content → InsightFace → Detect Faces → Extract Embeddings
→ Match Against Registered Identities → Create Consent Requests
→ Notify Identity Owners → Return Status
```

### 3. Consent Approval Flow
```
Identity Owner → View Request → Approve → Generate Token
→ Update Content Status → Creator Can Download
```

## Key Components

### Backend (`backend/`)

- **`main.py`**: FastAPI application with REST endpoints
- **`face_service.py`**: InsightFace integration for face detection/embedding
- **`consent_engine.py`**: Core consent workflow logic
- **`database.py`**: SQLAlchemy models and database setup

### Frontend (`frontend/`)

- **`app/page.tsx`**: Landing page with dashboard selection
- **`app/identity-owner/page.tsx`**: Identity owner dashboard
- **`app/creator/page.tsx`**: Content creator dashboard
- **`lib/api.ts`**: API client configuration

## Security & Privacy Features

1. **No Raw Image Storage**: Only face embeddings (512-dim vectors) stored
2. **Human-in-the-Loop**: All consent requires explicit approval
3. **Explainable Scoring**: Confidence scores visible to all parties
4. **Token-Based Verification**: Cryptographic consent tokens
5. **Content Hashing**: Duplicate detection via SHA-256

## API Endpoints

### Identity Owner
- `POST /api/register-face` - Register face
- `GET /api/consent-requests` - Get requests
- `POST /api/approve-consent` - Approve request
- `POST /api/reject-consent` - Reject request

### Content Creator
- `POST /api/upload-content` - Upload content
- `GET /api/verify-status/{id}` - Check status
- `GET /api/download-content/{id}` - Download approved

### General
- `GET /api/validate-token/{token}` - Validate token
- `GET /health` - Health check

## Technology Stack

### Backend
- **FastAPI**: Async REST API framework
- **InsightFace**: Face recognition (buffalo_l model)
- **SQLAlchemy**: ORM for database
- **SQLite**: MVP database (upgradeable to PostgreSQL)

### Frontend
- **Next.js 14**: React framework with App Router
- **TypeScript**: Type safety
- **Tailwind CSS**: Styling
- **Axios**: HTTP client

## Scalability Considerations

1. **Database**: SQLite → PostgreSQL + pgvector for production
2. **Storage**: Local files → Cloud storage (S3, Azure Blob)
3. **Processing**: CPU → GPU acceleration (CUDA)
4. **Caching**: Add Redis for frequent queries
5. **Queue**: Add Celery/RQ for async processing
6. **API**: Rate limiting, authentication, API keys

## Future Enhancements

- Decentralized Identity (DID) support
- Blockchain-based consent tokens
- Video and real-time scanning
- Platform-native plugins
- Multi-face consent workflows
- Batch processing API

## Pitch Statement

> "Our architecture is API-first and decentralized-ready, but today we focus on proving consent enforcement works."

