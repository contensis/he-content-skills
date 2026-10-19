---
name: website-audit
description: Use when auditing a whole university website — not a single page — against a fixed set of criteria: brand, content quality, accessibility, GDPR/privacy policy, site ownership, content freshness, audience size/analytics access, and duplication across the university's wider web estate.
---

# Website Audit

> Crawl a university website and audit it against eight criteria — five page-level, three estate-level — each rated Red/Amber/Green.

## Task

Given a starting URL for a university website (or a section of one), crawl a bounded set of its pages and rate them against the eight criteria below.

**Crawl:**

- Discover pages from `sitemap.xml`; otherwise crawl internal links breadth-first.
- Default limit: **~25 pages, depth 2**; the user may change it or narrow the starting path. Never imply full coverage of a larger site.
- Always fetch any privacy/cookie policy page found, outside the page budget — it usually sits beyond a shallow crawl (e.g. `/privacy-policy`).
- If you can fetch pages but not discover them, ask for a list of URLs. If you can't fetch at all, say so and ask for pasted content. Never fabricate crawl results.

**Date anchor.** Take today's date from your environment (ask if unavailable; never infer it from training data) and judge dated claims against it and the current UK academic year.

**Scope.** Judge from markup and text only — no screenshots or colour-contrast measurement. A Green on Accessibility or Brand reflects markup-level signals, not a full visual/WCAG pass.

**Raw HTML.** Criteria 3 and 7 need raw markup (`alt`, labels, ARIA, `<script>`), which many fetch tools strip. Use a raw-HTML fetch (e.g. `curl`) where available — no scripts in stripped text is not evidence of no analytics.

**JavaScript rendering.** If a fetch lacks expected sections (e.g. fees on a course page, a footer) or most internal links, they are likely loaded by JavaScript. Rate the affected criteria Not assessed — a site-wide pattern means AI crawlers may miss them too.

**Optional inputs:** a brand/style guide and/or quality bar. Without them, use the defaults under Brand and Quality and say so.

## Criteria

Rate each criterion **Red**, **Amber**, or **Green** — or **Not assessed**, with the reason, when the evidence it needs wasn't available.

### Page-level (one row per crawled page)

**1 — Brand.** Tone of voice, terminology, messaging consistency (not visual identity). Default bar: consistent tone, no unexplained jargon, second-person address to prospective students, no contradictions across pages. Green = consistent; Amber = some inconsistency; Red = contradicts the bar or another page.

**2 — Quality.** Clarity, specificity and accuracy of claims, fitness for purpose. Default bar: clear structure, verifiable claims (no vague filler), no placeholder/broken content, appropriate length. Green = meets bar; Amber = some vague/filler content; Red = substantial vague, inaccurate-looking, placeholder, or broken content.

**3 — Accessibility.** Heading hierarchy, alt attributes, descriptive link text, form labels, basic ARIA. From text without raw HTML, judge only headings and link text. Green = no issues found; Amber = minor issues (one skipped heading level, weak link text); Red = missing alt text on meaningful images, broken heading hierarchy, or unlabelled fields.

**4 — GDPR (privacy policy).** Is a policy linked, and does it cover data controller identity, what's collected, a contact/DPO route, and user rights? Green = linked consistently and all four present; Amber = linked but missing elements, generic/templated, or inconsistent; Red = no policy link found.

**5 — Up-to-date.** Primarily the page's own last-updated/reviewed date; where absent, time-bound claims (academic year, deadline, named person) as corroborating evidence. Default threshold **12 months** (user may override). Green = dated within threshold, or no date and no time-bound claims; Amber = no date and unverifiable time-bound claims; Red = dated beyond threshold, or tied to a past cycle (e.g. "2025 entry" in 2026/27).

### Estate-level (reported once for the site)

**6 — Ownership.** In-page signals only (footer/contact/about text), not true organisational/CMS ownership. Green = named owner and contact route; Amber = owner implied (e.g. faculty name in URL/branding) but not stated; Red = no ownership signal.

**7 — Audience size / analytics access.** *Detection*: scan raw HTML for analytics tooling (GA4/gtag.js, GTM, Matomo, Adobe Analytics, Plausible). A GTM or consent-manager container alone counts as probable analytics. *Access and size*: unknowable from content — don't pause to ask; list both under Needs your input. Green = detected and access confirmed; Amber = detected or probable, access unconfirmed; Red = raw HTML of every page checked, no analytics or tag manager.

**8 — Duplication.** *Within-crawl*: compare crawled pages' main content (ignore shared navigation and footers) for near-identical or overlapping text. *Estate-wide*, only with a search tool: up to 3 site-restricted searches per page on distinctive phrases, labelled as a sample; without one, say estate-wide wasn't checked. Green = no duplication; Amber = partial overlap; Red = near-identical duplicate.

## Output format

1. **Header** — date and academic year, starting URL, crawl method, page/depth limit vs. pages crawled, raw HTML or text only, scope note, pages with suspected JavaScript-rendered content, and whether default Brand/Quality bars were used.
2. **Page-level table** — one row per crawled page, none omitted: Page URL, Brand, Quality, Accessibility, GDPR, Up-to-date, each cell a rating with a one-line reason.
3. **Estate-level block** — Ownership, Audience/analytics, Duplication, each a rating with evidence.
4. **Summary row** — worst rating per page-level column, ignoring Not assessed cells.
5. **Needs your input** — questions only the user can answer (analytics access, monthly users/sessions) and which ratings each answer would change.

## Constraints

- Every rating cites its evidence (a quote, URL, or observed absence) — no rating that could apply to any site.
- Missing evidence is Not assessed, never Red or Green.
- Don't guess organisational facts (true ownership, analytics access, audience size) — ask under Needs your input.
