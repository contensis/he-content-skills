---
name: graduate-outcomes
description: Use when writing or refreshing the careers/graduate-outcomes section of a university course detail page — the roles, sectors, further-study routes, and employment or salary statistics prospective students can expect after completing a course.
---

# Graduate Outcomes

> Produce the careers/graduate-outcomes section of a university course detail page — sourced where evidence exists, clearly flagged where it doesn't.

> Worked example: [examples/input-01.txt](examples/input-01.txt) → [examples/output-01.md](examples/output-01.md)

## Task

Produce (or refresh) the "what can this course lead to" section of a course detail page: the roles and sectors graduates typically enter, further study routes, and — only where evidence supports it — salary and employment statistics. It works on its own; no full page rewrite is needed.

**Input — accept any of:**

- Course name + subject/level — the minimum (e.g. "BSc Computer Science, undergraduate"); expect most roles/sectors to be `[INFERRED]`
- Existing course content (module list, department source copy), pasted or fetched
- A URL to the live/draft page — fetch it if your tools allow; otherwise ask for the content to be pasted
- Pre-supplied outcomes data (a HESA export, department stats, alumni case studies) — the highest-priority source, ahead of anything found independently

## Context

- **Audience:** Prospective undergraduate students aged 17–19, unless the course name/level indicates otherwise (e.g. "MSc", "PGCE", "PhD" imply postgraduate/CPD/research framing)
- **Tone:** Warm, direct, plain English. Second person ("you could go on to..."). Benefit-led
- **Reading level:** Flesch-Kincaid Grade 10 or below
- **Purpose:** Help a prospective student see realistic, evidenced destinations for this course — not a generic "employability" pitch

## Sourcing standard

Check supplied content first, then search the web where your tools support it.

**Acceptable sources:** HESA Graduate Outcomes / Discover Uni, Prospects.ac.uk, LMI For All, professional or regulatory body sites (e.g. RIBA, BPS), and the institution's own published data. Not acceptable: general blogs, forums, unattributed listicles.

Cite every externally sourced claim — source name, URL, and date retrieved. These figures decay fast; an uncited number is not usable.

**No web access:** say so explicitly, and fall back to role/sector inference from the course subject, tagged `[INFERRED]`.

Never fabricate a stat, employer, or alumni example. Named employers and alumni are never `[INFERRED]` — a name is either real and cited, or left out.

## Tags

Apply per item in a bulleted list, not once for the whole list:

| Tag | Meaning |
|-----|---------|
| [VERIFY] | Sourced and cited, but confirm with the institution before publishing — e.g. the stat is a couple of years old, or may be for the wrong course level |
| [INFERRED] | Plausible for the subject but not backed by a specific source for this course — a reasonable guess, not an evidenced claim |
| [MISSING] | No source and no reasonable inference possible |

## Output format

Deliver as a single markdown document:

**Section heading (H2)**
Question-form preferred, since AI search engines extract answers more reliably from question-aligned headings: "Where can it take you?" or "What can you do with a [subject] degree?"

**Introduction**
1–2 sentences, 30–50 words, framing the range of outcomes. Check the word count with a real tool (shell `wc`, Python `len()`) rather than estimating.

**Roles & sectors**
Bulleted list, 4–8 items, each tagged `[VERIFY]` or `[INFERRED]`.

**Salary**
Separate from employment statistics. Only if sourced: a range with source and retrieval date (e.g. "£24,000–£32,000 starting salary, Prospects.ac.uk, retrieved 2026-07"). Never a single invented figure; never per-role unless the source breaks it down that way. Omit entirely if unsourced.

**Further study routes**
0–4 items, each tagged. Omit the field if the subject has no meaningful postgraduate or professional pathway, rather than padding it.

**Employment statistics**
Only if sourced (e.g. "% in work or further study 15 months after graduating"). Omit the sub-heading entirely if nothing is sourced — no empty or placeholder block.

**Named employers / alumni examples**
Only if sourced.

**Sources**
Last content field. Every citation: source name, URL, date retrieved.

Separate the page copy above from the field below with a horizontal rule (`---`) — it is editor-facing, not page copy:

**Review checklist**
Every `[VERIFY]`, `[INFERRED]`, and `[MISSING]` item restated with what to confirm and with whom where obvious.

## Constraints

- Do not use phrases like "world-class", "cutting-edge", or "unique" without specific supporting evidence
- Do not use unexplained acronyms — expand on first use (e.g. "Higher Education Statistics Agency (HESA)")
