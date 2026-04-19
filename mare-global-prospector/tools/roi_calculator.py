from langchain_core.tools import tool
from shared.dtos import IncentiveCalculation

@tool
def calculate_roi(monthly_clients: int, avg_retail_ticket: float) -> IncentiveCalculation:
    """
    Calculates the projected ancillary revenue jump for a salon adopting the MaRe system.
    Always call this tool before drafting the outreach email.
    
    Args:
        monthly_clients: The average number of clients the salon sees per month.
        avg_retail_ticket: The average dollar amount a client spends when they buy retail products.
        
    Returns:
        An IncentiveCalculation object containing the current and projected revenue metrics.
    """
    # Industry standard vs. MaRe System conversions
    CURRENT_CONVERSION_RATE = 0.03  # 3%
    MARE_CONVERSION_RATE = 0.40     # 40%

    # Calculate current baseline
    current_buyers = monthly_clients * CURRENT_CONVERSION_RATE
    current_monthly_retail_rev = current_buyers * avg_retail_ticket

    # Calculate MaRe projected baseline
    projected_buyers = monthly_clients * MARE_CONVERSION_RATE
    projected_monthly_retail_rev = projected_buyers * avg_retail_ticket

    # The "Value" Metric - what the agent will use in the hook
    estimated_ancillary_revenue = projected_monthly_retail_rev - current_monthly_retail_rev
    
    # Calculate the multiplier
    roi_multiplier = projected_monthly_retail_rev / current_monthly_retail_rev if current_monthly_retail_rev > 0 else 0

    # Return the strict Pydantic DTO instead of a raw dictionary
    return IncentiveCalculation(
        current_retail_conversion_rate=CURRENT_CONVERSION_RATE,
        projected_retail_conversion_rate=MARE_CONVERSION_RATE,
        estimated_ancillary_revenue=round(estimated_ancillary_revenue, 2),
        roi_multiplier=round(roi_multiplier, 2)
    )
