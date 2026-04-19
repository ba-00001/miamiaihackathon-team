from pydantic import BaseModel, HttpUrl, Field
from typing import List, Optional

class IncentiveCalculation(BaseModel):
    """Calculated ROI metrics for the MaRe Eye system."""
    current_retail_conversion_rate: float = Field(..., description="Default is typically 0.03 (3%)")
    projected_retail_conversion_rate: float = Field(..., description="Target is 0.40 (40%)")
    estimated_ancillary_revenue: float
    roi_multiplier: float

class SalonProfile(BaseModel):
    """The enriched data profile of a prospective salon."""
    id: str
    name: str
    location: str
    website_url: Optional[HttpUrl] = None
    instagram_handle: Optional[str] = None
    estimated_revenue: str = Field(..., description="E.g., '$1M+', '<$500k'")
    aesthetic_tags: List[str] = Field(default_factory=list, description="E.g., ['Luxury', 'Wellness', 'Systematic']")
    brands_carried: List[str] = Field(default_factory=list)
    compatibility_score: int = Field(..., ge=0, le=100, description="MaRe match score 0-100")

class OutreachDraft(BaseModel):
    """The LangGraph AI-generated communication draft."""
    salon_id: str
    hook: str = Field(..., description="Sentence 1: The personalized vibe check.")
    value_prop: str = Field(..., description="Sentence 2: The MaRe Eye ROI.")
    guardrail: str = Field(..., description="Sentence 3: The exclusivity filter.")
    full_message: str
    incentives: Optional[IncentiveCalculation] = None
    status: str = Field(default="draft", description="State in LangGraph: 'draft', 'approved', 'sent'")