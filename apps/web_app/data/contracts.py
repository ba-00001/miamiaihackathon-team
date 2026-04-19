from __future__ import annotations

from dataclasses import asdict, dataclass
from typing import Optional


@dataclass(frozen=True)
class IncentiveCalculation:
    current_retail_conversion_rate: float
    projected_retail_conversion_rate: float
    estimated_ancillary_revenue: float
    roi_multiplier: float

    def to_dict(self) -> dict:
        return asdict(self)


@dataclass(frozen=True)
class OutreachDraft:
    salon_id: str
    hook: str
    value_prop: str
    guardrail: str
    full_message: str
    incentives: Optional[IncentiveCalculation]
    status: str

    def to_dict(self) -> dict:
        payload = asdict(self)
        if self.incentives is not None:
            payload["incentives"] = self.incentives.to_dict()
        return payload


@dataclass(frozen=True)
class SalonProfile:
    id: str
    name: str
    location: str
    website_url: Optional[str]
    instagram_handle: Optional[str]
    estimated_revenue: str
    aesthetic_tags: list[str]
    brands_carried: list[str]
    compatibility_score: int

    def to_dict(self) -> dict:
        return asdict(self)
