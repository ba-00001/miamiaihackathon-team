export type MetricSummary = {
  luxuryProspects: number;
  approvedOutreach: number;
  contentAssetsReady: number;
  retailLiftPotential: string;
};

export type AiErrorState = {
  hasError: boolean;
  title: string;
  description: string;
  fallbacks: string[];
};

export type ProspectSignal = {
  id: string;
  name: string;
  cityState: string;
  revenueBand: string;
  aestheticSignal: string;
  locations: number;
  fitScore: number;
  socialHook: string;
  reasons: string[];
};

export type OutreachDraft = {
  salonName: string;
  channel: string;
  subjectLine: string;
  hook: string;
  body: string;
  postcardConcept: string;
  guardrail: string;
};

export type ContentAsset = {
  id: string;
  format: string;
  title: string;
  primaryKeyword: string;
  openingHook: string;
  talkingPoints: string[];
  callToAction: string;
  status: string;
};

export type ReviewItem = {
  id: string;
  owner: string;
  lane: string;
  status: string;
  nextAction: string;
  fallback: string;
};

export type GrowthEngineSnapshot = {
  generatedAt: string;
  marketFocus: string;
  headline: string;
  statusDotColor: string;
  metrics: MetricSummary;
  aiError: AiErrorState;
  prospects: ProspectSignal[];
  outreachDrafts: OutreachDraft[];
  contentAssets: ContentAsset[];
  reviewQueue: ReviewItem[];
};

export type AgentState = {
  status: string;
  tone: string;
  nextAction: string;
  yellowDot: boolean;
  fallbackMessage: string;
};
