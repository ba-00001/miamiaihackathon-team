import 'dart:convert';

import '../models/models.dart';

const _mareAppJson = r'''
{
  "appName": "MaRe",
  "tagline": "One luxury scalp-health app for guests, MaRe growth teams, partner salons, and clients.",
  "updatedAt": "2026-04-19T11:45:00-04:00",
  "guest": {
    "title": "Discover MaRe without signing in",
    "description": "Guest mode lets prospects, future salon partners, and curious clients explore the MaRe brand, luxury rituals, education, and partner value before creating an account.",
    "highlights": [
      "Browse luxury scalp-health education",
      "Find partner salons and MaRe locations",
      "Apply to become a MaRe salon partner"
    ],
    "sections": [
      {
        "title": "Explore the brand",
        "subtitle": "A public-facing path for curious visitors who want to understand the MaRe system first.",
        "cards": [
          {
            "title": "Luxury scalp rituals",
            "subtitle": "Public education",
            "detail": "Guests can explore scalp-health routines, MaRe product stories, and what makes the head-spa experience feel premium rather than clinical.",
            "tags": ["Guest", "Education", "Luxury"],
            "stats": [
              {"label": "Public modules", "value": "12"},
              {"label": "Starter rituals", "value": "6"}
            ]
          },
          {
            "title": "Find a MaRe location",
            "subtitle": "Salon discovery",
            "detail": "Guests can find salons, compare locations, and preview service menus before they ever sign in.",
            "tags": ["Guest", "Map", "Partner salons"],
            "stats": [
              {"label": "Miami launch", "value": "Live"},
              {"label": "Expansion markets", "value": "4"}
            ]
          }
        ]
      },
      {
        "title": "Become a partner",
        "subtitle": "A lightweight path for salon owners who want to raise their hand before onboarding.",
        "cards": [
          {
            "title": "Partner interest form",
            "subtitle": "Prospect intake",
            "detail": "High-end salons can submit location, aesthetic, and service information so MaRe can qualify them before outreach.",
            "tags": ["Partner", "Lead capture", "Luxury fit"],
            "stats": [
              {"label": "Avg review time", "value": "24h"},
              {"label": "Required fields", "value": "7"}
            ]
          }
        ]
      }
    ]
  },
  "roles": [
    {
      "id": "internal",
      "title": "MaRe Internal",
      "audience": "Founders, growth, marketing, and operations",
      "summary": "Prospect salons, generate luxury outreach, scale content, and manage approvals.",
      "heroTitle": "Scale partner acquisition without losing the luxury signal.",
      "heroDescription": "This internal experience helps the MaRe team move from discovery to outreach to content production while keeping every risky action under human approval.",
      "quickActions": [
        "Review top salon prospects",
        "Approve outreach drafts",
        "Release AI-search content"
      ],
      "sections": [
        {
          "title": "Global Prospector",
          "subtitle": "Revenue-ranked discovery and qualification for target salon partners.",
          "cards": [
            {
              "title": "Luxury-fit salon queue",
              "subtitle": "Prospect ranking",
              "detail": "Rank salons by luxury aesthetic, multi-location strength, service mix, and probable retail upside.",
              "tags": ["Prospecting", "Ranking", "Luxury fit"],
              "stats": [
                {"label": "Qualified salons", "value": "12,480"},
                {"label": "High-confidence tier", "value": "3,240"}
              ]
            },
            {
              "title": "Revenue confidence review",
              "subtitle": "Guarded AI verification",
              "detail": "When revenue certainty drops, the app routes uncertain prospects into review instead of allowing aggressive automation.",
              "tags": ["AI review", "Fallback", "Human approval"],
              "stats": [
                {"label": "Flagged leads", "value": "14"},
                {"label": "Manual lane", "value": "Enabled"}
              ]
            }
          ]
        },
        {
          "title": "Luxury Outreach",
          "subtitle": "Salon-lingo messaging that sounds selective, human, and premium.",
          "cards": [
            {
              "title": "Personalized outreach drafts",
              "subtitle": "Email, DM, postcard",
              "detail": "Generate hooks grounded in the salon's real aesthetic, location, and retail opportunity while preserving brand exclusivity.",
              "tags": ["Outreach", "Salon lingo", "Selective"],
              "stats": [
                {"label": "Approved drafts", "value": "42"},
                {"label": "Auto-send", "value": "Blocked"}
              ]
            }
          ]
        },
        {
          "title": "Creative Engine",
          "subtitle": "AI-search-ready content creation for blogs, Shorts, and social.",
          "cards": [
            {
              "title": "Luxury content queue",
              "subtitle": "Search and social",
              "detail": "Generate education-led content around scalp health, dandruff solutions, routines, and head-spa rituals while preserving the MaRe tone.",
              "tags": ["Content", "AI search", "Scalp wellness"],
              "stats": [
                {"label": "Assets ready", "value": "56"},
                {"label": "Weekly target", "value": "50+"}
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
      "summary": "Track partner performance, staff enablement, consultation quality, and reorder needs.",
      "heroTitle": "Give partner salons a clear operating system, not just a product shelf.",
      "heroDescription": "The salon-owner role focuses on retail lift, consultation quality, staff training, MaRe Eye workflows, and local marketing assets.",
      "quickActions": [
        "Review partner analytics",
        "Upload consultation images",
        "Reorder retail stock"
      ],
      "sections": [
        {
          "title": "Partner Dashboard",
          "subtitle": "A live operating view for salon performance and retail conversion.",
          "cards": [
            {
              "title": "Retail conversion performance",
              "subtitle": "Partner analytics",
              "detail": "Owners can see how MaRe consultations translate into product attachment, repeat visits, and staff performance.",
              "tags": ["Partner", "Analytics", "Retail lift"],
              "stats": [
                {"label": "Conversion lift", "value": "3% → 40%+"},
                {"label": "Active stylists", "value": "18"}
              ]
            },
            {
              "title": "Consultation image vault",
              "subtitle": "AWS S3 storage",
              "detail": "Before-and-after photos, scalp scans, and training examples route through AWS-backed media storage with safe upload fallback.",
              "tags": ["Images", "AWS S3", "Compliance"],
              "stats": [
                {"label": "Stored assets", "value": "2,140"},
                {"label": "Storage mode", "value": "Presigned"}
              ]
            }
          ]
        },
        {
          "title": "Staff Enablement",
          "subtitle": "Train the floor team to use MaRe consistently and confidently.",
          "cards": [
            {
              "title": "Training and scripts",
              "subtitle": "Stylist support",
              "detail": "Give stylists the right consultation language, protocol steps, and partner-approved marketing assets.",
              "tags": ["Training", "Scripts", "Support"],
              "stats": [
                {"label": "Completion rate", "value": "91%"},
                {"label": "Launch assets", "value": "24"}
              ]
            }
          ]
        }
      ]
    },
    {
      "id": "client",
      "title": "Client",
      "audience": "Consumers and salon clients",
      "summary": "Follow a personal scalp-health journey with routines, appointments, progress, and product recommendations.",
      "heroTitle": "Turn every consultation into a personal scalp-health journey.",
      "heroDescription": "The client experience keeps routines, progress photos, appointments, and personalized education in one luxury app shell.",
      "quickActions": [
        "View scalp profile",
        "Book an appointment",
        "Reorder routine products"
      ],
      "sections": [
        {
          "title": "My Journey",
          "subtitle": "Personalized care, progress, and follow-up in one place.",
          "cards": [
            {
              "title": "Scalp profile and progress",
              "subtitle": "Client timeline",
              "detail": "Clients can review their scalp concerns, timeline photos, and treatment milestones without needing salon back-office access.",
              "tags": ["Client", "Timeline", "Progress"],
              "stats": [
                {"label": "Sessions logged", "value": "8"},
                {"label": "Progress photos", "value": "26"}
              ]
            },
            {
              "title": "Routine and reorder",
              "subtitle": "Care continuity",
              "detail": "Keep recommended routines, reorder reminders, and product education tied directly to the client profile.",
              "tags": ["Routine", "Shop", "Education"],
              "stats": [
                {"label": "Routine steps", "value": "4"},
                {"label": "Reorder reminder", "value": "On"}
              ]
            }
          ]
        }
      ]
    }
  ],
  "storage": {
    "provider": "aws-s3",
    "bucket": "mare-demo-assets",
    "region": "us-east-1",
    "prefix": "uploads",
    "mode": "demo",
    "fallback": "If signed uploads fail, keep the media workflow visible, store metadata safely, and route the asset into human review."
  },
  "aiNotice": {
    "hasError": true,
    "title": "AI output is guarded by role and fallback mode",
    "description": "Guest users only see public education, salon owners only see partner data, and clients only see their own journey. Any uncertain AI output is downgraded into a safe review path instead of becoming silent automation.",
    "fallbacks": [
      "Fallback to approved templates when live generation is unavailable.",
      "Block sends or publishes until a human approves uncertain output.",
      "Keep the yellow dot visible anywhere AI or fallback logic is active."
    ]
  }
}
''';

final demoMareAppSnapshot = MareAppSnapshot.fromJson(
  jsonDecode(_mareAppJson) as Map<String, dynamic>,
);
