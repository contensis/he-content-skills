# Context

Glossary of terms for this repository, resolved during design/grilling sessions. Implementation details belong in skill files, not here.

Primarily higher-education web content skills, with one deliberate exception (`write-blogpost` — see [ADR-0002](docs/adr/0002-write-blogpost-generic-scope.md)).

## Terms

### `write-blogpost` (skill)

A generic, audience-agnostic skill for drafting and critiquing blog posts — not scoped to HE content like the rest of this collection. Two inferred modes: Draft (from a topic/audience/goal brief) and Critique (score an existing draft against the skill's quality rubric and suggest fixes, without producing a full rewrite).

### `graduate-outcomes` (skill)

A standalone skill that produces or audits the careers/further-study outcomes content for a course detail page — the roles, sectors, further-study routes, and (where sourced) employment statistics a prospective student could expect after completing a course.

Distinct from `refine-for-web`'s "Where can it take you?" body section: that section is produced as part of a full-document rewrite from raw source copy. `graduate-outcomes` is invokable on its own, e.g. to add or refresh just the outcomes section of an existing page without a full rewrite. `refine-for-web` may reference `graduate-outcomes` the way it already references `alt-text` and `geo-audit`.

**Sourcing standard.** The skill actively looks for outcomes evidence — in supplied source content first, then more broadly on the web when the runtime supports fetching/search. Acceptable source types: HESA Graduate Outcomes / Discover Uni, Prospects.ac.uk, LMI For All, professional/regulatory body sites, and the institution's own published data. No general blogs, forums, or unattributed listicles. Every externally sourced stat is cited (source name + URL + date retrieved), mirroring `staleness-audit`'s date-anchoring since these figures decay fast.

**No web access fallback.** When the runtime has no fetch/search capability (some hosted-assistant installs), the skill says so explicitly and falls back to generic role/sector inference from the course subject, flagged as inferred rather than sourced — it never fabricates specific stats, employers, or alumni to fill the gap.

### `website-audit` (skill)

Audits a whole university website — not a single page — against eight criteria: Brand, Quality, Accessibility, GDPR, Ownership, Up-to-date, Audience size/analytics access, and Duplication. Distinct from the page-level audit skills (`staleness-audit`, `alt-text`, `geo-audit`), which take a single page's content and judge it against a fixed rubric. `website-audit`'s unit of work is a **web estate**: it crawls a bounded set of pages from a starting URL (sitemap-first, capped breadth-first fallback) because several of its criteria — Ownership, Audience, Duplication — only make sense at estate level, not per page. See [ADR-0003](docs/adr/0003-website-audit-scope.md) for why it crawls and defines its own rubrics rather than reusing `alt-text`/`staleness-audit` as sub-checks.

**Page-level vs estate-level criteria.** Brand, Quality, Accessibility, GDPR, and Up-to-date can vary per crawled page and are reported per page; Ownership, Audience size/analytics, and Duplication are inherent to the site as a whole and are reported once, at estate level.

**Not assessed.** A fourth rating alongside Red/Amber/Green, used when the evidence a criterion needs wasn't available — no raw HTML, content hidden by JavaScript, a failed fetch. It keeps missing evidence distinct from a finding: an absence the skill couldn't look for is never reported as Red, and an unchecked page is never reported as Green.
