# Business And Technical To Dos

## Business To Do

- Validate the role boundaries between guest, internal, salon-owner, and client experiences.
- Confirm what actions are public in guest mode versus sign-in only.
- Validate the ideal salon profile with MaRe founders using 20 to 30 real target accounts.
- Build the partner exclusivity policy by geography and salon tier.
- Create the real ROI calculator inputs for conversion lift, retail attachment, and retention.
- Define the review workflow for approving outreach, partner lists, and content batches.

## Technical To Do

- Connect real authentication and persistent role mapping.
- Connect live prospecting sources such as Clay, Firecrawl, or salon datasets.
- Store generated assets, approval history, and fallback events in a database.
- Move demo S3 targets to fully signed AWS upload flows and lifecycle policies.
- Add real LLM integrations and prompt versioning for each role path.
- Integrate image and video providers for production-grade assets.
- Add retry queues, caching, and monitoring so AI failure does not stop the product.
- Add end-to-end tests for web and widget tests for Flutter.

## AI Error Display Rules

- Never fail silently.
- Convert AI issues into visible cards with business language.
- Keep the fallback path visible.
- Keep the yellow dot present in all AI or fallback states.
- Default to safe, cached, or human-reviewed output instead of risky automation.
