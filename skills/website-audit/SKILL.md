---
name: website-audit
description: Use when auditing a whole university website — not a single page — against a fixed set of criteria: brand, content quality, accessibility, GDPR/privacy policy, site ownership, content freshness, audience size/analytics access, and duplication across the university's wider web estate.
argument-hint: [website-url]
metadata: { author: Richard Saunders, version: 1.0 }
user-invocable: true
---

# Website Audit

> Crawl a university website and audit it against eight criteria — five page-level, three estate-level — each rated Red/Amber/Green.

## Task

Given a starting URL for a university website (or section of one), crawl a bounded set of its pages and audit them against the eight criteria below. Report page-level criteria per page in a table, and estate-level criteria once for the site as a whole. Finish with a summary row showing the worst rating per criterion across the crawl.

This is a whole-*website* audit, distinct from this collection's page-level audits (`staleness-audit`, `alt-text`, `geo-audit`), which judge a single page's content against a fixed rubric. Ownership, Audience, and Duplication are meaningless at single-page granularity, so the unit of work here is the site. See [ADR-0003](../../docs/adr/0003-website-audit-scope.md) for why this skill crawls and uses its own rubrics rather than orchestrating `alt-text`/`staleness-audit`.

**Crawl:**

- Prefer `sitemap.xml` for page discovery; otherwise a breadth-first crawl of internal links.
- Default limit: **~25 pages, depth 2**. State the actual limit and pages crawled at the top of the report — never imply full coverage of a larger site. The user may override the limit or narrow the starting path.
- **Legal/policy pages are never capped** — any privacy/cookie policy page found is always fetched for the GDPR check regardless of budget, since it typically sits outside a shallow crawl radius (e.g. `/privacy-policy`).
- **No fetch/crawl capability:** say so, and ask for a supplied list of page URLs or pasted content instead.

**Scope — text/HTML only:** all eight criteria are judged from markup and text, not rendered visuals — no screenshots, no colour-contrast measurement. State this once near the top; a Green on Accessibility or Brand reflects markup-level signals only, not a full visual/WCAG pass.

**Optional inputs:** a brand/style guide and/or quality bar. If neither is supplied, use the generic defaults under Brand/Quality below and say so explicitly.

## Criteria

Rate each **Red**/**Amber**/**Green**, always citing the evidence (a quote, URL, or observed absence) behind the rating — no rating that could apply to any site.

### Page-level (one row per crawled page)

**1 — Brand.** Tone of voice, terminology, messaging consistency (not visual identity). Default bar: consistent tone, no unexplained jargon, second-person address to prospective students, no contradictions across pages. Green = consistent; Amber = some inconsistency; Red = contradicts the bar or another page.

**2 — Quality.** Clarity, specificity/accuracy of claims, fitness for purpose — distinct from Brand (tone) and Accessibility. Default bar: clear structure, verifiable claims (no vague filler), no placeholder/broken content, appropriate length. Green = meets bar; Amber = some vague/filler content; Red = substantial vague, inaccurate-looking, placeholder, or broken content.

**3 — Accessibility.** Markup-level only: heading hierarchy, alt attributes, descriptive link text, form labels, basic ARIA. Green = no issues found; Amber = minor issues (one skipped heading level, weak link text); Red = missing alt text on meaningful images, broken heading hierarchy, or unlabelled fields. Not a full WCAG audit — visual contrast is out of scope.

**4 — GDPR (privacy policy).** Is a policy linked, and does it cover: data controller identity, what's collected, a contact/DPO route, user rights? Green = linked consistently and all four present; Amber = linked but missing elements, generic/templated, or inconsistent; Red = no policy link found.

**5 — Up-to-date.** Primarily the page's own last-updated/reviewed signal; where absent, time-bound claims (academic year, deadline, named person) as corroborating evidence only. Green = recent explicit date, or no date and no time-bound claims; Amber = no date and unverifiable time-bound claims; Red = date past a reasonable threshold, or content clearly tied to a past cycle.

### Estate-level (reported once for the site)

**6 — Ownership.** In-page signals only (footer/contact/about text) — not true organisational/CMS ownership. Green = named owner + contact route stated; Amber = owner implied (e.g. faculty name in URL/branding) but not explicit; Red = no ownership signal found.

**7 — Audience size / analytics access.** *Detection*: scan markup for known analytics tooling (GA4/gtag.js, GTM, Matomo, Adobe Analytics). *Access*: unknowable from page content — always report "Unknown, requires user confirmation" and ask, never guess. Green = analytics detected and access confirmed; Amber = detected but access unconfirmed; Red = none detected.

**8 — Duplication.** *Within-crawl* (always): compare crawled pages for near-identical/overlapping content. *Estate-wide* (only if a search tool exists): a capped number of site-restricted searches on distinctive phrases (e.g. up to 3 per page), labelled as a sample. If no search tool, say estate-wide couldn't be checked. Green = no duplication found; Amber = partial overlap; Red = near-identical duplicate found.

## Output format

1. **Header** — starting URL, crawl method, page/depth limit vs. actual pages crawled, text/HTML-only scope note.
2. **Page-level table** — one row per crawled page: Page URL, Brand, Quality, Accessibility, GDPR, Up-to-date, each cell a RAG rating with a one-line reason. No page omitted regardless of crawl size.
3. **Estate-level block** — Ownership, Audience/analytics, Duplication, each a RAG rating with evidence.
4. **Summary row** — worst rating per page-level column across the crawl.

## Constraints

- Every rating cites its evidence — no generic ratings.
- Don't fabricate crawl results when tools are unavailable — say so, ask for supplied pages.
- Don't guess organisational facts (true ownership, analytics access) — report unknown and ask.
- If no brand guide/quality rubric supplied, say the generic defaults were used.
