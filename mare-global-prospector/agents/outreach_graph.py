import os
import json
from psycopg_pool import ConnectionPool
from typing import TypedDict, Annotated, Optional

from langgraph.graph import StateGraph, START, END
from langgraph.graph.message import add_messages
from langgraph.checkpoint.postgres import PostgresSaver

from langchain_google_genai import ChatGoogleGenerativeAI
from langchain_core.messages import SystemMessage, HumanMessage

from tools.roi_calculator import calculate_roi
from dotenv import load_dotenv
from shared.dtos import SalonProfile, OutreachDraft

load_dotenv()

# State Definition
class OutreachState(TypedDict):
    salon_profile: dict          
    messages: Annotated[list, add_messages]
    roi_data: Optional[dict]
    final_draft: Optional[dict]          
    human_feedback: Optional[str]  

# Node 1: The Analyst Agent
def analyst_node(state: OutreachState):
    """Extracts parameters and runs the ROI calculation."""
    
    # If we already have ROI data (e.g., regenerating after human feedback), skip.
    if state.get("roi_data"):
        return state 

    llm = ChatGoogleGenerativeAI(
        model="gemini-2.5-flash", 
        temperature=0.5, 
        project=os.getenv("GOOGLE_CLOUD_PROJECT")
    ).bind_tools([calculate_roi])
    
    prompt = f"""
    Analyze this salon profile: {json.dumps(state['salon_profile'])}.
    You MUST call the `calculate_roi` tool. If foot traffic is unknown, use 1000. If ticket price is unknown, use $85.
    """
    
    response = llm.invoke(prompt)
    
    roi_result = None
    if response.tool_calls:
        tool_call = response.tool_calls[0]
        if tool_call["name"] == "calculate_roi":
            raw_result = calculate_roi.invoke(tool_call["args"]) 
            roi_result = raw_result.model_dump() if hasattr(raw_result, "model_dump") else raw_result
    
    return {"messages": [response], "roi_data": roi_result}

# Node 2: The Copywriter Agent
def copywriter_node(state: OutreachState):
    """Drafts the outreach email."""        
    base_llm = ChatGoogleGenerativeAI(
        model="gemini-2.5-flash", project=os.getenv("GOOGLE_CLOUD_PROJECT")
    )
    structured_llm = base_llm.with_structured_output(
        schema=OutreachDraft.model_json_schema(), method="json_schema"
    )
    
    prompt = f"""
    You are the elite Biz Dev Lead for MaRe.
    Write a B2B outreach message for this salon: 
    {json.dumps(state['salon_profile'])}

    You MUST incorporate this calculated ROI data into the value proposition: 
    {json.dumps(state['roi_data'])}.
    """
    
    messages = [HumanMessage(content=prompt)]
    
    if state.get("human_feedback"):
        messages.append(HumanMessage(content=f"The human Growth Lead rejected the previous draft. Please revise it using this specific feedback: {state['human_feedback']}"))
    
    draft_dict = structured_llm.invoke(messages)

    return {
        "final_draft": draft_dict, 
        "human_feedback": None 
    }

# Node 3: The Send Node (Human Review Pause Gate)
def send_email_node(state: OutreachState):
    """Executes after human approval."""
    print(f"🚀 SENDING EMAIL: {state['final_draft']['full_message']}")
    return state

def route_after_human(state: OutreachState):
    """Decides if we revise the draft or send the email."""
    if state.get("human_feedback"):
        return "copywriter"
    
    return "send_email"

workflow = StateGraph(OutreachState)

workflow.add_node("analyst", analyst_node)
workflow.add_node("copywriter", copywriter_node)
workflow.add_node("human_gate", lambda state: state) 
workflow.add_node("send_email", send_email_node)

# 1. Start -> Analyst -> Copywriter
workflow.add_edge(START, "analyst")
workflow.add_edge("analyst", "copywriter")

# 2. Copywriter -> Human Gate (Where it will pause)
workflow.add_edge("copywriter", "human_gate")

# 3. From the Human Gate, use the traffic cop to decide the next step
workflow.add_conditional_edges(
    "human_gate", 
    route_after_human,
    {
        "copywriter": "copywriter", # Go back and revise
        "send_email": "send_email"  # Move forward and send
    }
)

workflow.add_edge("send_email", END)

DB_URI = os.environ.get("DATABASE_URL")
# 6. Checkpointer Configuration
def get_compiled_app():
    # The connection pool manages connections in the serverless environment
    pool = ConnectionPool(
        conninfo=DB_URI, 
        kwargs={"autocommit": True} 
    )
    checkpointer = PostgresSaver(pool)

    # This creates the necessary tables automatically if they don't exist
    checkpointer.setup() 

    return workflow.compile(
        checkpointer=checkpointer,
        interrupt_before=["send_email"]
    )