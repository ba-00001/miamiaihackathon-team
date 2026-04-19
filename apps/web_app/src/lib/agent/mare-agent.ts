import { growthEngineSnapshot } from "@/lib/mock-data";
import type { AgentState } from "@/lib/types";

export function runMareAgent(): AgentState {
  const guarded = growthEngineSnapshot.aiError.hasError;

  return {
    status: guarded ? "guarded" : "ready",
    tone: "luxury, warm, systematic",
    nextAction: guarded
      ? "Keep the drafts visible, but block automated send until a human verifies the uncertain salons."
      : "Release approved outreach and move content into publishing.",
    yellowDot: true,
    fallbackMessage:
      "If live AI services fail, keep cached strategy visible, shift to approved templates, and preserve the yellow dot so the developer knows fallback mode is active.",
  };
}
