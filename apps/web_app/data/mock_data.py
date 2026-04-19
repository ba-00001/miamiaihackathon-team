from data.contracts import IncentiveCalculation, OutreachDraft, SalonProfile


DEMO_SALON_PROFILES = [
    SalonProfile(
        id="salon-001",
        name="Rosette Ritual House",
        location="Miami, FL",
        website_url="https://rosetteritualhouse.example",
        instagram_handle="@rosetteritualhouse",
        estimated_revenue="$1.8M-$2.4M",
        aesthetic_tags=["Luxury ritual", "Scalp wellness", "Editorial retail"],
        brands_carried=["Philip Martin's", "Prestige scalp care"],
        compatibility_score=96,
    ).to_dict(),
    SalonProfile(
        id="salon-002",
        name="Casa de Soleil Salon Spa",
        location="Palm Beach, FL",
        website_url="https://casadesoleil.example",
        instagram_handle="@casadesoleilspa",
        estimated_revenue="$2.7M-$3.1M",
        aesthetic_tags=["Italian interiors", "Wellness-first", "Multi-location"],
        brands_carried=["Philip Martin's", "Luxury treatment menus"],
        compatibility_score=93,
    ).to_dict(),
]

DEMO_OUTREACH_DRAFTS = [
    OutreachDraft(
        salon_id="salon-001",
        hook="Your social feed already feels like a private-membership scalp club, which is rare.",
        value_prop="MaRe pairs Italian luxury formulas with a diagnostic camera that helps stylists move from generic recommendation to visual proof while protecting premium positioning.",
        guardrail="Only position MaRe as a selective partnership for salons that are luxury enough.",
        full_message="Your social feed already feels like a private-membership scalp club, which is rare. MaRe pairs Italian luxury formulas with a diagnostic camera that helps stylists move from generic recommendation to visual proof. The result is stronger loyalty, higher retail conversion, and a partner story that still feels exclusive.",
        incentives=IncentiveCalculation(
            current_retail_conversion_rate=0.12,
            projected_retail_conversion_rate=0.41,
            estimated_ancillary_revenue=186000.0,
            roi_multiplier=3.4,
        ),
        status="approved",
    ).to_dict(),
    OutreachDraft(
        salon_id="salon-002",
        hook="The wellness language in your brand already sets up the MaRe Eye perfectly.",
        value_prop="We help salons turn scalp consultations into a visible, educational experience that lifts confidence and retail attachment without diluting a luxury service menu.",
        guardrail="Keep the message high-end, consultative, and specific to their visual brand.",
        full_message="The wellness language in your brand already sets up the MaRe Eye perfectly. We help salons turn scalp consultations into a visible, educational experience that lifts confidence and retail attachment. Instead of adding noise, MaRe sharpens your premium positioning with a systematic ritual clients can see and repeat.",
        incentives=IncentiveCalculation(
            current_retail_conversion_rate=0.15,
            projected_retail_conversion_rate=0.43,
            estimated_ancillary_revenue=224000.0,
            roi_multiplier=3.9,
        ),
        status="needs_review",
    ).to_dict(),
]

MARE_APP_SNAPSHOT = {
    "appName": "MaRe",
    "tagline": "One luxury scalp-health app for guests, MaRe internal teams, partner operators, and end users.",
    "updatedAt": "2026-04-19T16:10:00-04:00",
    "guest": {
        "title": "Discover MaRe without signing in",
        "description": "Guest mode lets wellness enthusiasts, future partner locations, and curious end users explore the MaRe brand, session experience, product universe, and partner value before creating an account.",
        "highlights": [
            "Browse luxury scalp-health education",
            "Find partner salons and MaRe locations",
            "Shop shampoos, treatments, tools, and gift kits",
            "Apply to become a MaRe salon partner or distributor",
        ],
        "sections": [
            {
                "title": "Persona",
                "subtitle": "A refined public entry for the first MaRe impression.",
                "cards": [
                    {
                        "title": "Sophia Vale",
                        "subtitle": "Wellness enthusiast and destination guest",
                        "detail": "Sophia is a high-earning professional who values elevated rituals, trusted guidance, and visible results. She wants to understand the MaRe world, discover the right location, and invest in products that feel luxurious and effective.",
                        "tags": ["Guest persona", "High earner", "Luxury wellness"],
                        "stats": [
                            {"label": "Primary intent", "value": "Discover + book"},
                            {"label": "Preferred tone", "value": "Quiet luxury"},
                        ],
                    }
                ],
            },
            {
                "title": "Explore the brand",
                "subtitle": "A public-facing path for wellness enthusiasts who want to understand the MaRe system first.",
                "cards": [
                    {
                        "title": "Luxury scalp rituals",
                        "subtitle": "Public education",
                        "detail": "Guests can explore scalp-health routines, MaRe product stories, and what makes the head-spa experience feel premium rather than clinical, from AI diagnostics to Italian scalp rituals.",
                        "tags": ["Guest", "Education", "Luxury"],
                        "stats": [
                            {"label": "Public modules", "value": "12"},
                            {"label": "Starter rituals", "value": "6"},
                        ],
                    },
                    {
                        "title": "Find a MaRe location",
                        "subtitle": "Salon discovery",
                        "detail": "Guests can find partner salons and MaRe locations, compare destination fit, and preview services before they ever sign in.",
                        "tags": ["Guest", "Map", "Partner salons"],
                        "stats": [
                            {"label": "Miami launch", "value": "Live"},
                            {"label": "Expansion markets", "value": "4"},
                        ],
                    },
                    {
                        "title": "What to expect from a session",
                        "subtitle": "Science meets serenity",
                        "detail": "Show the guest flow from AI scalp scan and questionnaire into a personalized treatment plan, immersive head-spa ritual, and post-treatment home-care guidance.",
                        "tags": ["Session flow", "AI scan", "Home care"],
                        "stats": [
                            {"label": "Express session", "value": "30 min"},
                            {"label": "Extended ritual", "value": "60-90 min"},
                        ],
                    },
                ],
            },
            {
                "title": "Shop and join",
                "subtitle": "Give guests a clear path into products, membership, and professional interest.",
                "cards": [
                    {
                        "title": "Product finder",
                        "subtitle": "Cosmetics and tools",
                        "detail": "Guests can browse MaRe cosmetics, scalp and hair tools, light therapy devices, and gift kits, including shampoos and rinses aligned to their scalp concerns.",
                        "tags": ["Shop", "Shampoo finder", "Tools"],
                        "stats": [
                            {"label": "Core categories", "value": "4"},
                            {"label": "Top examples", "value": "Purifying Wash, In Amber Wash"},
                        ],
                    },
                    {
                        "title": "Partner and distributor intake",
                        "subtitle": "Prospect intake",
                        "detail": "High-end salons, spas, clinics, hotels, wellness centers, and distributors can submit territory and business details so MaRe can qualify them before outreach.",
                        "tags": ["Partner", "Lead capture", "Distributor"],
                        "stats": [
                            {"label": "Avg review time", "value": "24h"},
                            {"label": "Qualified segments", "value": "6"},
                        ],
                    },
                    {
                        "title": "Member updates",
                        "subtitle": "Wellness enthusiast journey",
                        "detail": "Guests can join the MaRe member list for first access to treatments, innovations, education, and local launch updates.",
                        "tags": ["Membership", "Updates", "Wellness"],
                        "stats": [
                            {"label": "Member promise", "value": "First access"},
                            {"label": "Tone", "value": "Luxury wellness"},
                        ],
                    },
                ],
            },
        ],
    },
    "roles": [
        {
            "id": "internal",
            "title": "MaRe Internal",
            "audience": "MaRe growth lead, sales team, and prospect salon pipeline managers",
            "summary": "Prospect premium partners, manage outreach, support distributors, scale content, and keep risky actions in human review.",
            "heroTitle": "Scale the MaRe network without losing the luxury signal.",
            "heroDescription": "This internal experience helps the MaRe team move from premium partner discovery to outreach, distributor enablement, and content production while keeping risky actions under human approval.",
            "quickActions": [
                "Review top salon prospects",
                "Approve outreach drafts",
                "Route distributor and territory leads",
                "Release AI-search content",
            ],
            "sections": [
                {
                    "title": "Persona",
                    "subtitle": "A decision-maker focused on selective expansion.",
                    "cards": [
                        {
                            "title": "Avery Laurent",
                            "subtitle": "MaRe growth lead",
                            "detail": "Avery is responsible for growing the MaRe partner network without eroding the brand. She needs high-confidence prospecting, selective outreach, territory awareness, and human-reviewed AI outputs that feel premium and precise.",
                            "tags": ["Growth lead", "Selective expansion", "Human review"],
                            "stats": [
                                {"label": "Primary outcome", "value": "Qualified partners"},
                                {"label": "Brand bar", "value": "Exceptionally high"},
                            ],
                        }
                    ],
                },
                {
                    "title": "Target network",
                    "subtitle": "Qualify the right partner type before sales effort begins.",
                    "cards": [
                        {
                            "title": "Luxury-fit partner queue",
                            "subtitle": "Prospect ranking",
                            "detail": "Rank salons, spas, clinics, hotels, wellness centers, and distributors by luxury aesthetic, territory potential, service mix, and retail upside.",
                            "tags": ["Prospecting", "Ranking", "Luxury fit"],
                            "stats": [
                                {"label": "Qualified salons", "value": "12,480"},
                                {"label": "High-confidence tier", "value": "3,240"},
                            ],
                        },
                        {
                            "title": "Segment and territory review",
                            "subtitle": "Guarded AI verification",
                            "detail": "When segment fit or territory confidence drops, the app routes uncertain prospects into review instead of allowing aggressive automation.",
                            "tags": ["AI review", "Fallback", "Human approval"],
                            "stats": [
                                {"label": "Flagged leads", "value": "14"},
                                {"label": "Manual lane", "value": "Enabled"},
                            ],
                        },
                        {
                            "title": "Partner types in play",
                            "subtitle": "B2B expansion map",
                            "detail": "Track how MaRe expands across salons, spas, clinics, hotels, wellness centers, and distributor networks while preserving brand selectivity.",
                            "tags": ["Expansion", "B2B", "Territories"],
                            "stats": [
                                {"label": "Target segments", "value": "6"},
                                {"label": "Priority territories", "value": "8"},
                            ],
                        },
                    ],
                },
                {
                    "title": "Luxury Outreach",
                    "subtitle": "Partner-specific messaging that sounds selective, human, and premium.",
                    "cards": [
                        {
                            "title": "Personalized outreach drafts",
                            "subtitle": "Email, DM, postcard",
                            "detail": "Generate hooks grounded in the partner's aesthetic, location, and retail opportunity while preserving brand exclusivity and the MaRe partnership tone.",
                            "tags": ["Outreach", "Salon lingo", "Selective"],
                            "stats": [
                                {"label": "Approved drafts", "value": "42"},
                                {"label": "Auto-send", "value": "Blocked"},
                            ],
                        },
                        {
                            "title": "Sales and distributor toolkit",
                            "subtitle": "Enablement",
                            "detail": "Package product guides, territory decks, certification details, and print-ready partner assets so the growth and sales team can move faster.",
                            "tags": ["Sales enablement", "Toolkit", "Certification"],
                            "stats": [
                                {"label": "Playbooks live", "value": "9"},
                                {"label": "Co-branded assets", "value": "24"},
                            ],
                        },
                    ],
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
                                {"label": "Weekly target", "value": "50+"},
                            ],
                        },
                        {
                            "title": "Member and launch storytelling",
                            "subtitle": "Awareness and retention",
                            "detail": "Generate wellness-led content around scalp detox, aging scalp, sensory reset, and local launch moments so guests and end users stay connected to MaRe.",
                            "tags": ["Membership", "Blog", "Retention"],
                            "stats": [
                                {"label": "Launch narratives", "value": "5"},
                                {"label": "Blog lanes", "value": "Education + wellness"},
                            ],
                        },
                    ],
                },
            ],
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
                "Reorder retail stock",
            ],
            "sections": [
                {
                    "title": "Persona",
                    "subtitle": "An operator who wants prestige, precision, and measurable uplift.",
                    "cards": [
                        {
                            "title": "Isabella Moreau",
                            "subtitle": "Partner salon owner",
                            "detail": "Isabella runs a premium salon and wants MaRe to feel like a signature extension of her brand. She needs diagnostics, staff confidence, certification, and retail performance without ever cheapening the guest experience.",
                            "tags": ["Partner owner", "Retail lift", "Luxury operations"],
                            "stats": [
                                {"label": "Primary outcome", "value": "Prestige + growth"},
                                {"label": "Service style", "value": "High-touch"},
                            ],
                        }
                    ],
                },
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
                                {"label": "Active stylists", "value": "18"},
                            ],
                        },
                        {
                            "title": "Consultation image vault",
                            "subtitle": "AWS S3 storage",
                            "detail": "Before-and-after photos, scalp scans, and training examples route through AWS-backed media storage with safe upload fallback.",
                            "tags": ["Images", "AWS S3", "Compliance"],
                            "stats": [
                                {"label": "Stored assets", "value": "2,140"},
                                {"label": "Storage mode", "value": "Presigned"},
                            ],
                        },
                        {
                            "title": "MaRe Eye consultations",
                            "subtitle": "Protocol precision",
                            "detail": "Use AI scalp imaging, visit history, and protocol recommendations to personalize rituals and drive stronger retail confidence.",
                            "tags": ["MaRe Eye", "AI diagnostics", "Protocol"],
                            "stats": [
                                {"label": "Reports shared", "value": "312"},
                                {"label": "Visit history", "value": "Saved"},
                            ],
                        },
                    ],
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
                                {"label": "Launch assets", "value": "24"},
                            ],
                        },
                        {
                            "title": "Certification and partner support",
                            "subtitle": "Turnkey enablement",
                            "detail": "Give staff access to certification, treatment protocols, wholesale guidance, retail upselling playbooks, and dedicated partner support.",
                            "tags": ["Certification", "Wholesale", "Support"],
                            "stats": [
                                {"label": "Training lanes", "value": "3"},
                                {"label": "Preferred pricing", "value": "Enabled"},
                            ],
                        },
                    ],
                },
            ],
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
                "Shop shampoos and tools",
            ],
            "sections": [
                {
                    "title": "Persona",
                    "subtitle": "A discerning client who expects results to feel beautifully personal.",
                    "cards": [
                        {
                            "title": "Camille Ashford",
                            "subtitle": "End user and private client",
                            "detail": "Camille is affluent, image-conscious, and wellness-driven. She wants to find the right MaRe partner, understand what her session will feel like, follow her scalp journey, and shop products that match her concerns without guesswork.",
                            "tags": ["End user", "High earner", "Personalized care"],
                            "stats": [
                                {"label": "Primary outcome", "value": "Guided confidence"},
                                {"label": "Shopping style", "value": "Recommendation-led"},
                            ],
                        }
                    ],
                },
                {
                    "title": "My Journey",
                    "subtitle": "Personalized care, progress, and follow-up in one place.",
                    "cards": [
                        {
                            "title": "Scalp profile and progress",
                            "subtitle": "End-user timeline",
                            "detail": "End users can review their scalp concerns, timeline photos, and treatment milestones without needing salon back-office access.",
                            "tags": ["End user", "Timeline", "Progress"],
                            "stats": [
                                {"label": "Sessions logged", "value": "8"},
                                {"label": "Progress photos", "value": "26"},
                            ],
                        },
                        {
                            "title": "Routine and reorder",
                            "subtitle": "Care continuity",
                            "detail": "Keep recommended routines, reorder reminders, and product education tied directly to the end-user profile.",
                            "tags": ["Routine", "Shop", "Education"],
                            "stats": [
                                {"label": "Routine steps", "value": "4"},
                                {"label": "Reorder reminder", "value": "On"},
                            ],
                        },
                        {
                            "title": "Partner location finder",
                            "subtitle": "Where to go next",
                            "detail": "Let end users find the right MaRe partner location, compare availability, and move from curiosity into booking with the right operator.",
                            "tags": ["Location", "Booking", "Partner salons"],
                            "stats": [
                                {"label": "Bookable cities", "value": "4"},
                                {"label": "Session fit", "value": "Guided"},
                            ],
                        },
                    ],
                },
                {
                    "title": "Products and sessions",
                    "subtitle": "Bridge in-salon rituals with home-care and product discovery.",
                    "cards": [
                        {
                            "title": "Shampoo and treatment finder",
                            "subtitle": "Shop by concern",
                            "detail": "Guide end users to washes, rinses, scalp treatments, tools, and light therapy products aligned to dryness, buildup, sensitivity, thinning, or maintenance.",
                            "tags": ["Products", "Shampoo", "Recommendations"],
                            "stats": [
                                {"label": "Examples", "value": "Purifying Wash, In Amber Wash"},
                                {"label": "Shop lanes", "value": "Cosmetics + tools"},
                            ],
                        },
                        {
                            "title": "What to expect",
                            "subtitle": "Before, during, after",
                            "detail": "Set expectations around AI scalp scan, questionnaire, treatment plan, immersive ritual, and post-treatment product recommendations so the experience feels intentional.",
                            "tags": ["Session", "Education", "Luxury ritual"],
                            "stats": [
                                {"label": "Entry step", "value": "AI scan"},
                                {"label": "Finish", "value": "Home-care plan"},
                            ],
                        },
                        {
                            "title": "Member access",
                            "subtitle": "Stay connected",
                            "detail": "Keep first-access updates, treatment launches, educational content, and saved preferences inside the same account used for booking and shopping.",
                            "tags": ["Membership", "Updates", "Saved preferences"],
                            "stats": [
                                {"label": "Access", "value": "First-launch updates"},
                                {"label": "Favorites", "value": "Saved"},
                            ],
                        },
                    ],
                },
            ],
        },
    ],
    "aiNotice": {
        "hasError": True,
        "title": "AI output is guarded by role and fallback mode",
        "description": "Guest users only see public education, salon owners only see partner data, and end users only see their own journey. Any uncertain AI output is downgraded into a safe review path instead of becoming silent automation.",
        "fallbacks": [
            "Fallback to approved templates when live generation is unavailable.",
            "Block sends or publishes until a human approves uncertain output.",
            "Keep the yellow dot visible anywhere AI or fallback logic is active.",
        ],
    },
    "internalData": {
        "salonProfiles": DEMO_SALON_PROFILES,
        "outreachDrafts": DEMO_OUTREACH_DRAFTS,
    },
}


AGENT_STATE = {
    "status": "guarded",
    "tone": "luxury, warm, systematic",
    "nextAction": "Let guests browse publicly, let signed-in users select their role, and keep every uncertain AI action inside human review while routing partner, product, and booking flows by role.",
    "yellowDot": True,
    "fallbackMessage": "If live AI services fail, MaRe keeps the role shell visible, falls back to approved templates, and preserves the yellow dot to show a guarded state.",
}
