# MaRe B2B Outreach Agent

The MaRe Outreach Agent is a production-grade, multi-agent AI pipeline built with **LangGraph** and **FastAPI**. It is designed to automate B2B sales outreach for the MaRe salon system by analyzing prospective salon data, calculating projected ROI, and generating highly personalized outreach drafts. 

Crucially, it utilizes a **Human-in-the-Loop (HITL)** architecture, pausing the AI pipeline to allow human Growth Leads (Marianna/Rebecca) to review, edit, or approve drafts before they are sent.

---

## 🧠 System Architecture

The backend utilizes a linear, two-agent deterministic flow:

1. **The Analyst Agent:** Evaluates the `SalonProfile`, determines missing variables, and strictly executes the `calculate_roi` Python tool to project the ancillary revenue jump the salon would experience using MaRe.
2. **The Copywriter Agent:** Takes the output from the Analyst and uses Gemini's **Native JSON Schema Output** (`with_structured_output`) to reliably generate a B2B draft without hallucinating data formats.
3. **The Human Gate:** The graph serializes its state to a **PostgreSQL Database**, pauses execution, and returns the draft to the frontend.
4. **The Revision Loop:** If a human provides feedback, a traffic-cop router sends the state *back* to the Copywriter for revision until explicitly approved.

---

## 🚀 API Reference

Base URL: `http://localhost:8080` (Local) or `https://<YOUR_CLOUD_RUN_URL>` (Production)

### 1. Start a New Draft
Triggers the multi-agent pipeline to calculate ROI and write the initial draft.

**POST** `/drafts/start`
* **Content-Type:** `application/json`
* **Body:**
```json
{
  "salon_profile": {
    "id": "salon_igk_mia_001",
    "name": "IGK Miami",
    "location": "Miami, FL",
    "website_url": "[https://igkhair.com](https://igkhair.com)",
    "instagram_handle": "@igksalons",
    "estimated_revenue": "$2M+",
    "aesthetic_tags": ["Luxury", "Modern", "Systematic"],
    "brands_carried": ["Oribe", "IGK"],
    "compatibility_score": 95
  }
}
```
* **Response:** Returns the parsed JSON draft and a `paused` status indicating it is waiting for human review.

### 2. Review / Edit / Approve
Triggers the graph to resume from its paused state in the PostgreSQL database.

**POST** `/drafts/review`
* **Content-Type:** `application/json`

**Scenario A: Requesting an Edit**
```json
{
  "salon_id": "salon_igk_mia_001",
  "action": "edit",
  "feedback": "Make the tone a bit more luxurious and mention their specific aesthetic."
}
```

**Scenario B: Approving the Draft**
```json
{
  "salon_id": "salon_igk_mia_001",
  "action": "approve"
}
```

---

## 🛠️ Local Development

### Prerequisites
* Python 3.11+
* Docker Desktop (for running local Postgres)
* Google Cloud CLI (`gcloud`) installed and authenticated

### Setup
1. Clone the repository and install dependencies:
   ```bash
   pip install -r requirements.txt
   ```
2. Authenticate locally with Google Cloud to enable Vertex AI:
   ```bash
   gcloud auth application-default login
   gcloud auth application-default set-quota-project YOUR_GCP_PROJECT_ID
   ```
3. Start a local Postgres database:
   ```bash
   docker run --name local-postgres -e POSTGRES_PASSWORD=mysecretpassword -p 5432:5432 -d postgres
   ```
4. Run the FastAPI server:
   ```bash
   DATABASE_URL=postgresql://postgres:mysecretpassword@localhost:5432/postgres uvicorn main:app --host 127.0.0.1 --port 8080 --reload
   ```

---

## ☁️ Google Cloud Deployment

This application is designed to be deployed entirely serverless using **Google Cloud Run** and **Cloud SQL**.

### 1. Provision Infrastructure
* Create a **Cloud SQL (PostgreSQL)** instance. Create a database named `langgraph_state`.
* Enable the **Vertex AI API** and **Cloud SQL Admin API** in your GCP project.
* Give your Compute Engine Default Service Account the following IAM roles:
  * `Vertex AI User`
  * `Cloud SQL Client`
  * `Secret Manager Secret Accessor`

### 2. Set Secrets
Go to Google Secret Manager and create a secret named `DB_CONNECTION_STRING`. 

### 3. Deploy to Cloud Run
Run the following command in the root of the backend directory. The `--add-cloudsql-instances` flag securely mounts the database via a Unix socket, bypassing public firewalls.

```bash
gcloud run deploy mare-outreach-agent \
  --source . \
  --platform managed \
  --region us-east1 \
  --allow-unauthenticated \
  --set-secrets="DATABASE_URL=DB_CONNECTION_STRING:latest" \
  --add-cloudsql-instances="YOUR_PROJECT:REGION:INSTANCE_NAME" \
  --project="YOUR_GCP_PROJECT_ID"
```

Once deployed, update your Flutter application's HTTP client to point to the provided Cloud Run Service URL.