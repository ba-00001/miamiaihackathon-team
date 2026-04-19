import 'dart:convert';

import '../models/models.dart';

const _snapshotJson = '''
{
  "generatedAt": "2026-04-19T10:45:00-04:00",
  "marketFocus": "Miami proof of concept with nationwide luxury expansion",
  "headline": "The MaRe Luxury Growth Engine",
  "statusDotColor": "yellow",
  "metrics": {
    "luxuryProspects": 12480,
    "approvedOutreach": 42,
    "contentAssetsReady": 56,
    "retailLiftPotential": "3% to 40%+"
  },
  "aiError": {
    "hasError": true,
    "title": "Revenue verification gap on 14 shortlisted salons",
    "description": "The AI agent could not fully verify recent revenue signals on a small subset of premium salons, so it switched to a multi-signal confidence score and pushed those accounts into human review instead of sending risky outreach.",
    "fallbacks": [
      "Use aesthetic score, location density, and premium services as the temporary ranking stack.",
      "Hold auto-send until a human approves the final prospect tier.",
      "Swap to alternate search phrasing focused on head spa, scalp ritual, and luxury wellness."
    ]
  },
  "prospects": [
    {
      "id": "salon-001",
      "name": "Rosette Ritual House",
      "cityState": "Miami, FL",
      "revenueBand": "$1.8M-$2.4M",
      "aestheticSignal": "Scalp ritual storytelling + high-touch retail shelves",
      "locations": 2,
      "fitScore": 96.0,
      "socialHook": "Your Brickell scalp bar visuals already educate clients like a wellness concierge.",
      "reasons": [
        "Premium scalp service menu",
        "Visible retail area with conversion opportunity",
        "Client comments signal loyalty and repeat traffic"
      ]
    },
    {
      "id": "salon-002",
      "name": "Casa de Soleil Salon Spa",
      "cityState": "Palm Beach, FL",
      "revenueBand": "$2.7M-$3.1M",
      "aestheticSignal": "Italian-inspired interiors and wellness-first positioning",
      "locations": 3,
      "fitScore": 93.0,
      "socialHook": "Your Palm Beach audience already buys prestige rituals; MaRe extends that into measurable scalp wellness.",
      "reasons": [
        "Luxury service packaging",
        "Multiple locations with consistent visual identity",
        "Hair + wellness cross-sell potential"
      ]
    },
    {
      "id": "salon-003",
      "name": "Atelier Verre",
      "cityState": "Scottsdale, AZ",
      "revenueBand": "$1.2M-$1.6M",
      "aestheticSignal": "Clean natural palette with editorial before-and-after content",
      "locations": 1,
      "fitScore": 90.0,
      "socialHook": "Your scalp-first transformations already prime clients for a diagnostic-led upsell conversation.",
      "reasons": [
        "High-end color clientele",
        "Service storytelling maps to MaRe education",
        "Smaller footprint but strong brand fit"
      ]
    }
  ],
  "outreachDrafts": [
    {
      "salonName": "Rosette Ritual House",
      "channel": "Email",
      "subjectLine": "A retail conversion ritual your Brickell clients would actually trust",
      "hook": "Your social feed already feels like a private-membership scalp club, which is rare.",
      "body": "MaRe pairs Italian luxury formulas with a diagnostic camera that helps stylists move from generic recommendation to visual proof. The result is stronger loyalty, higher retail conversion, and a partner story that still feels exclusive.",
      "postcardConcept": "Embossed ivory postcard with a single yellow status seal and the line: A system worthy of your service floor.",
      "guardrail": "Only position MaRe as a selective partnership for salons that are luxury enough."
    },
    {
      "salonName": "Casa de Soleil Salon Spa",
      "channel": "Postcard + DM",
      "subjectLine": "Palm Beach luxury clients are ready for scalp wellness with proof",
      "hook": "The wellness language in your brand already sets up the MaRe Eye perfectly.",
      "body": "We help salons turn scalp consultations into a visible, educational experience that lifts confidence and retail attachment. Instead of adding noise, MaRe sharpens your premium positioning with a systematic ritual clients can see and repeat.",
      "postcardConcept": "Satin cream stock featuring a gold circle, product silhouette, and a short ROI story.",
      "guardrail": "Keep the message high-end, consultative, and specific to their visual brand."
    }
  ],
  "contentAssets": [
    {
      "id": "content-001",
      "format": "YouTube Short",
      "title": "Why scalp health is the quiet luxury move for stronger hair",
      "primaryKeyword": "scalp health",
      "openingHook": "If your hair routine starts at the strand, you are already starting too late.",
      "talkingPoints": [
        "Scalp wellness as the foundation of visible hair quality",
        "Why diagnostic imaging improves trust",
        "How luxury rituals outperform product-only recommendations"
      ],
      "callToAction": "Book a MaRe consultation in Miami or apply to become a luxury partner salon.",
      "status": "Approved"
    },
    {
      "id": "content-002",
      "format": "Blog",
      "title": "The head spa routine affluent clients are asking for in 2026",
      "primaryKeyword": "head spa routine",
      "openingHook": "Luxury clients do not want more products; they want a system that feels personal.",
      "talkingPoints": [
        "What separates a scalp ritual from a basic wash",
        "Natural and organic cues that still feel high-end",
        "How salons monetize wellness without cheapening the brand"
      ],
      "callToAction": "Download the MaRe partner brief for salon owners.",
      "status": "In review"
    },
    {
      "id": "content-003",
      "format": "Instagram Reel",
      "title": "Dandruff solutions that still feel luxury",
      "primaryKeyword": "dandruff solutions",
      "openingHook": "Most dandruff content sounds clinical or cheap. Luxury clients deserve better education.",
      "talkingPoints": [
        "Explain scalp imbalance without fear tactics",
        "Show the MaRe Eye as a confidence builder",
        "End with a ritual upgrade instead of a hard sell"
      ],
      "callToAction": "Follow MaRe for scalp-first education and partner salon stories.",
      "status": "Ready to generate"
    }
  ],
  "reviewQueue": [
    {
      "id": "review-001",
      "owner": "Rebecca",
      "lane": "Prospect verification",
      "status": "Needs review",
      "nextAction": "Approve or downgrade the 14 uncertain luxury leads before outreach sends.",
      "fallback": "Export flagged salons into the manual CRM lane."
    },
    {
      "id": "review-002",
      "owner": "Marianna",
      "lane": "Brand voice",
      "status": "Approved",
      "nextAction": "Release the Palm Beach postcard concept to design production.",
      "fallback": "If tone slips into AI language, re-run with stricter salon lingo prompts."
    },
    {
      "id": "review-003",
      "owner": "Growth Ops",
      "lane": "AI search content",
      "status": "In progress",
      "nextAction": "Batch publish the approved Shorts and blog briefs into the publishing queue.",
      "fallback": "Fallback to blog-only output if video render credits are unavailable."
    }
  ]
}
''';

final demoGrowthEngineSnapshot = GrowthEngineSnapshot.fromJson(
  jsonDecode(_snapshotJson) as Map<String, dynamic>,
);
