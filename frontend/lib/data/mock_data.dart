import 'dart:convert';
import 'models.dart';

// --- Hardcoded State Data ---
final demoMareAppSnapshot = MareAppSnapshot.fromJson(jsonDecode(r'''
{
  "appName": "MaRe",
  "tagline": "One luxury scalp-health app for guests, internal teams, partners, and users.",
  "updatedAt": "2026-04-19T16:10:00-04:00",
  "guest": {
    "title": "Discover MaRe without signing in",
    "description": "Bridging the gap between boutique concept and nationwide luxury authority. Explore our high-end Italian cosmetics and professional scalp assessment protocols.",
    "highlights": ["Luxury Head Health", "Italian Cosmetics", "Professional Assessment", "MaRe Eye Technology"],
    "sections": [
      {
        "title": "The MaRe Philosophy",
        "subtitle": "Systematic. Luxury. Natural.",
        "cards": [
          {
            "title": "Beyond Basic Haircare",
            "subtitle": "A $130/session luxury brand experience",
            "detail": "MaRe is a luxury head health system that integrates professional scalp assessment with high-end Italian cosmetics. We offer protocols for hair care through salon and spa procedures paired with retail products.",
            "tags": ["Luxury", "Wellness", "Organic"],
            "stats": [{"label": "Experience", "value": "Premium"}]
          }
        ]
      },
      {
        "title": "The MaRe Eye",
        "subtitle": "Precision Scalp Diagnostics",
        "cards": [
          {
            "title": "See the Difference",
            "subtitle": "Professional Scalp Assessment",
            "detail": "Our proprietary MaRe Eye technology allows for hyper-personalized scalp diagnostics, ensuring every treatment is perfectly tailored to the client's unique needs.",
            "tags": ["Technology", "Diagnostics", "Precision"],
            "stats": [{"label": "Accuracy", "value": "100%"}]
          }
        ]
      }
    ]
  },
  "roles": [
    {
      "id": "internal",
      "title": "MaRe Internal",
      "audience": "MaRe growth lead and sales team",
      "summary": "Prospect premium partners, manage outreach, support distributors.",
      "heroTitle": "Scale the MaRe network without losing the luxury signal.",
      "heroDescription": "Move from premium partner discovery to outreach, distributor enablement, and content production.",
      "quickActions": ["Review prospects", "Approve outreach", "Creative Engine"],
      "sections": [
        {
          "title": "Target network",
          "subtitle": "Qualify the right partner type.",
          "cards": [
            {
              "title": "Luxury-fit partner queue",
              "subtitle": "Prospect ranking",
              "detail": "Rank salons, spas, and clinics by luxury aesthetic. Filter for $1M+ revenue corporate chains.",
              "tags": ["Prospecting", "B2B"],
              "stats": [
                {"label": "Qualified", "value": "12,480"},
                {"label": "High-Confidence", "value": "3,240"}
              ]
            }
          ]
        }
      ]
    },
    {
      "id": "owner",
      "title": "Salon Owner",
      "audience": "Partner owners, managers, and lead stylists",
      "summary": "Track partner performance, MaRe Eye workflows, training, certification, consultation quality, and reorder needs.",
      "heroTitle": "Give partner operators a full MaRe operating system, not just a product shelf.",
      "heroDescription": "The partner-owner role focuses on retail lift, MaRe Eye workflows, protocol mastery, training, certification, and local marketing assets.",
      "quickActions": [
        "Review partner analytics",
        "Upload consultation images",
        "Run training and certification",
        "Reorder retail stock"
      ],
      "sections": [
        {
          "title": "The Growth Catalyst",
          "subtitle": "Transform your retail performance.",
          "cards": [
            {
              "title": "Unprecedented Retail Lift",
              "subtitle": "From 3% to 40%+",
              "detail": "Retail conversion in salons is traditionally very low. By integrating the MaRe Eye camera and our systematic diagnostic approach, we take your retail conversion to 40%+.",
              "tags": ["ROI", "Conversion", "Retail"],
              "stats": [
                {"label": "Current Lift", "value": "40%+"},
                {"label": "Revenue Target", "value": "$1M+ "}
              ]
            },
            {
              "title": "Automated B2C Commission",
              "subtitle": "Ancillary Revenue Stream",
              "detail": "Generate effortless ancillary revenue through our automated B2C commission model. The system works for you even after the client leaves the chair.",
              "tags": ["Passive Income", "B2C", "Commission"],
              "stats": [
                {"label": "Model", "value": "Automated"}
              ]
            }
          ]
        },
        {
          "title": "The System, Not Just a Product",
          "subtitle": "Maintain your luxury fidelity.",
          "cards": [
            {
              "title": "Hyper-Premium Protocols",
              "subtitle": "Boutique Feel at Scale",
              "detail": "We solve the 'Personalized Scale Paradox'. Empower your stylists with luxury-standard tools that elevate the $130/session experience without feeling like a generic upsell. It is about empowering your salon as a true MaRe channel partner.",
              "tags": ["Protocols", "Luxury", "Fidelity"],
              "stats": [
                {"label": "Brand Fit", "value": "Goldilocks"},
                {"label": "Lingo", "value": "Salon-Native"}
              ]
            }
          ]
        }
      ]
    },
    {
      "id": "client",
      "title": "End User",
      "audience": "Wellness enthusiasts and salon clients",
      "summary": "Find partner locations, follow a personal scalp-health journey, and shop MaRe products with personalized recommendations.",
      "heroTitle": "Turn every consultation into a personal scalp-health and product journey.",
      "heroDescription": "The end-user experience keeps partner discovery, sessions, routines, progress photos, appointments, and personalized shopping in one luxury app shell.",
      "quickActions": [
        "Find a partner location",
        "View scalp profile",
        "Book an appointment",
        "Shop shampoos and tools"
      ],
      "sections": [
        {
          "title": "Your Personalized Scalp Journey",
          "subtitle": "Guided by the MaRe Eye",
          "cards": [
            {
              "title": "Precision Diagnostics",
              "subtitle": "A clear view of your scalp health",
              "detail": "Experience a hyper-personalized consultation using the MaRe Eye. We don't guess; we assess. Discover the exact Italian cosmetics your scalp needs to thrive.",
              "tags": ["Personalized", "Diagnostics", "MaRe Eye"],
              "stats": [
                {"label": "Consultation", "value": "Data-Driven"}
              ]
            }
          ]
        },
        {
          "title": "Luxury Head Spas",
          "subtitle": "Systematic, Natural, and Organic",
          "cards": [
            {
              "title": "The Ultimate Wellness Ritual",
              "subtitle": "Elevating your salon visit",
              "detail": "Immerse yourself in our premium head spa protocols. From targeted dandruff solutions to comprehensive hair care routines, every step is a luxury experience designed to bring the Miami boutique feel to you.",
              "tags": ["Head Spa", "Wellness", "Ritual"],
              "stats": [
                {"label": "Experience", "value": "Boutique"}
              ]
            },
            {
              "title": "Home Care Continuity",
              "subtitle": "Extend the benefits",
              "detail": "Take the $130/session luxury feel home with you. Easily reorder your prescribed natural and organic products directly through the app to maintain your scalp health.",
              "tags": ["Home Care", "Organic", "Results"],
              "stats": [
                {"label": "Quality", "value": "High-Fidelity"}
              ]
            }
          ]
        }
      ]
    }
  ],
  "storage": {
    "provider": "aws-s3", "bucket": "mare-media-assets", "region": "us-east-1", "prefix": "uploads", "mode": "production", "fallback": "If uploads fail, keep flow visible."
  },
  "aiNotice": {
    "hasError": false, "title": "AI Guardrails Active", "description": "All AI outputs require human approval.", "fallbacks": ["Block sends until human approves."]
  }
}
'''));

final demoGrowthEngineSnapshot = GrowthEngineSnapshot.fromJson(jsonDecode(r'''
{
  "generatedAt": "2026-04-19T10:45:00-04:00",
  "marketFocus": "Miami proof of concept",
  "headline": "MaRe Luxury Growth Engine",
  "statusDotColor": "yellow",
  "metrics": {
    "luxuryProspects": 12480, "approvedOutreach": 42, "contentAssetsReady": 56, "retailLiftPotential": "40%+"
  },
  "aiError": {
    "hasError": false, "title": "System Nominal", "description": "AI systems active.", "fallbacks": []
  },
  "prospects": [
    {
      "id": "salon-001", "name": "Rosette Ritual House", "cityState": "Miami, FL", "revenueBand": "$1.8M-$2.4M", "aestheticSignal": "Scalp ritual storytelling", "locations": 2, "fitScore": 96.0, "socialHook": "Your Brickell scalp bar visuals already educate clients.", "reasons": ["Premium scalp service menu"]
    }
  ],
  "outreachDrafts": [
    {
      "salonId": "salon-001", "hook": "Your social feed already feels like a private scalp club.", "valueProp": "MaRe pairs Italian luxury formulas with a diagnostic camera.", "guardrail": "Only position MaRe as a selective partnership.", "fullMessage": "Your social feed already feels like a private-membership scalp club, which is rare. MaRe pairs Italian luxury formulas with a diagnostic camera...",
      "incentives": {"roiMultiplier": 3.4}, "status": "approved"
    }
  ],
  "contentAssets": [],
  "reviewQueue": []
}
'''));