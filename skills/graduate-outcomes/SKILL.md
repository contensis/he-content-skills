---
name: graduate-outcomes
description: Use when writing or refreshing the careers/graduate-outcomes section of a university course detail page — the roles, sectors, further-study routes, and employment or salary statistics prospective students can expect after completing a course.
---

# Graduate Outcomes

> Produce the careers/graduate-outcomes section of a university course detail page — sourced where evidence exists, clearly flagged where it doesn't.

> Worked example: [examples/input-01.txt](examples/input-01.txt) → [examples/output-01.md](examples/output-01.md)

## Task

Produce (or refresh) the "what can this course lead to" section of a course detail page: the roles and sectors graduates typically enter, further study routes, and — only where evidence supports it — salary and employment statistics.

Standalone skill: it doesn't require a full document to refine. Course name and level alone is enough to produce a section, though a thinner, more heavily `[INFERRED]`-flagged one. For a full course-page rewrite, see the `refine-for-web` skill in this collection, which can call into this one for its "Where can it take you?" section.

**Input handling — accept any of:**

- Course name + subject/level (minimum viable input, e.g. "BSc Computer Science, undergraduate")
- Existing course content (module list, department source copy) pasted or fetched
- A URL to the live/draft page — fetch it if your tools allow; otherwise ask for the content to be pasted
- Pre-supplied outcomes data (a HESA export, department stats, alumni case studies) — treat this as the highest-priority source, ahead of anything found independently

The more source detail supplied, the higher the proportion of the output that's sourced (`[VERIFY]`) rather than inferred (`[INFERRED]`). With only a course name and level, expect most of the roles/sectors list to be `[INFERRED]`.

## Context

- **Audience:** Prospective undergraduate students aged 17–19, unless the course name/level indicates otherwise (e.g. "MSc", "PGCE", "PhD" imply postgraduate/CPD/research framing)
- **Tone:** Warm, direct, plain English. Second person ("you could go on to..."). Benefit-led
- **Reading level:** Flesch-Kincaid Grade 10 or below
- **Purpose:** Help a prospective student see realistic, evidenced destinations for this course — not a generic "employability" pitch

## Sourcing standard

Actively look for outcomes evidence: check supplied source content first, then search more broadly on the web where your tools support it (see [docs/adr/0001-graduate-outcomes-web-sourcing.md](../../docs/adr/0001-graduate-outcomes-web-sourcing.md) for why this skill searches the web when most others in this collection don't).

**Acceptable sources:** HESA Graduate Outcomes / Discover Uni, Prospects.ac.uk, LMI For All, professional or regulatory body sites (e.g. RIBA, BPS), and the institution's own published data. Not acceptable: general blogs, forums, unattributed listicles.

Cite every externally sourced stat — source name, URL, and date retrieved — in the sources list at the end. These figures decay fast; an uncited number is not usable.

**No web access:** if your tools have no fetch/search capability, say so explicitly rather than silently guessing, and fall back to generic role/sector inference from the course subject, flagged `[INFERRED]`. Never fabricate a specific stat, employer, or alumni example to fill the gap.

## Tags

Apply per item in a bulleted list, not once for the whole list:

| Tag | Meaning |
|-----|---------|
| [VERIFY] | Sourced claim that still needs institutional confirmation before publishing — e.g. the stat is a couple of years old, or may be for the wrong course level |
| [INFERRED] | Role or sector plausible for the subject but not backed by a specific source for this course — a reasonable guess, not an evidenced claim |
| [MISSING] | No source and no reasonable inference possible |

Named employers and alumni examples are never `[INFERRED]` — a name is either real and cited, or left out entirely.

## Constraints

- Roles & sectors: 4–8 bulleted items, each tagged individually
- Salary is its own field, separate from employment statistics — show only if sourced, as a range with source and retrieval date (e.g. "£24,000–£32,000 starting salary, Prospects.ac.uk, retrieved 2026-07"). Never a single invented figure. Never broken down per-role unless the source itself does so
- Further study routes: 0–4 items — omit the field entirely if the subject has no meaningful postgrad or professional pathway, rather than padding it
- Employment statistics: omit the sub-heading entirely if nothing is sourced — don't show an empty or placeholder block
- Verify character/word counts with a real tool (shell `wc`, Python `len()`) rather than estimating
- Do not use phrases like "world-class", "cutting-edge", or "unique" without specific supporting evidence
- Do not use unexplained acronyms — expand on first use (e.g. "Higher Education Statistics Agency (HESA)")

## Output format

Deliver as a single markdown document:

**Section heading (H2)**
Question-form preferred (GEO convention — AI search engines extract answers more reliably from question-aligned headings; see the `geo-audit` skill in this collection): "Where can it take you?" or "What can you do with a [subject] degree?"

**Introduction**
1–2 sentences, 30–50 words, framing the range of outcomes.

**Roles & sectors**
Bulleted list, 4–8 items, each tagged `[VERIFY]` or `[INFERRED]`.

**Salary**
Own field. Only if sourced. Range + source + retrieval date. Omit entirely if unsourced.

**Further study routes**
0–4 items, each tagged, only where relevant. Omit the field if not applicable.

**Employment statistics**
Only if sourced (e.g. "% in work or further study 15 months after graduating"). Omit the sub-heading if nothing is sourced.

**Named employers / alumni examples**
Only if sourced. Never invented.

**Sources**
Last content field before the checklist. Every citation: source name, URL, date retrieved.

Separate the page copy above from the fields below with a horizontal rule (`---`) — they are editor-facing, not page copy:

**Review checklist**
Every `[VERIFY]`, `[INFERRED]`, and `[MISSING]` item restated with what to confirm and with whom where obvious.
