from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from agents.outreach_graph import get_compiled_app
from shared.dtos import SalonProfile, OutreachDraft

app = FastAPI(title="MaRe Agent API")
graph_app = get_compiled_app()

class StartDraftRequest(BaseModel):
    salon_profile: SalonProfile

class ApprovalRequest(BaseModel):
    salon_id: str
    action: str # "approve" or "edit"
    feedback: str = None

@app.post("/drafts/start", response_model=dict)
def start_draft(request: StartDraftRequest):
    # Use the salon ID from the validated DTO
    config = {"configurable": {"thread_id": request.salon_profile.id}} 

    initial_state = {
        "salon_profile": request.salon_profile.model_dump(mode="json"),
        "messages": [("user", f"Start drafting for {request.salon_profile.name}.")]
    }
    
    for event in graph_app.stream(initial_state, config):
        pass
        
    state = graph_app.get_state(config)
    
    draft_dto: OutreachDraft = state.values.get("final_draft")
    return {
        "status": "paused", 
        "draft": state.values.get("final_draft")
    }

@app.post("/drafts/review")
def review_draft(request: ApprovalRequest):
    """Triggered by the frontend dashboard."""
    config = {"configurable": {"thread_id": request.salon_id}}
    
    if request.action == "approve":
        # Passing None resumes the graph from the interrupt
        graph_app.invoke(None, config)
        return {"status": "sent"}
        
    elif request.action == "edit":
        # Inject the human feedback and run it backward to the agent
        graph_app.update_state(config, {"human_feedback": request.feedback})
        for event in graph_app.stream(None, config):
            pass
            
        state = graph_app.get_state(config)
        return {"status": "updated_draft", "draft": state.values.get("final_draft")}