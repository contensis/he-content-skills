---
name: geo-audit
description: Use when auditing university web page content against GEO dimensions — whether AI-powered search engines (ChatGPT Search, Perplexity, Google AI Overviews, Bing Copilot) can understand, cite, and surface it to prospective students or researchers.
---

# GEO Audit

> Assess whether a web page is structured so AI-powered search engines can understand, cite, and surface it.

## Task

Given the full text content of a single web page — headings, body copy, any FAQs, plus the page title and any visible metadata (meta description, if known) — audit it against the five GEO dimensions below. For each dimension, give a rating of **Strong**, **Needs work**, or **Weak**, a one-sentence finding, and a specific recommendation.

- **Strong** = the dimension is fully addressed; an AI search engine could extract and cite this content with no changes
- **Needs work** = the dimension is partially addressed — some of the page meets it, some doesn't, or it works but not consistently
- **Weak** = the dimension is largely absent or actively hurts citability

**Input handling:**

- Pasted plain text is the expected input — no HTML required
- If given only a URL, fetch the page if your tools allow; otherwise ask for the content to be pasted
- If the content is too partial to audit fairly (a fragment, a single section), say so and list what is missing rather than rating it

## Context

- **Platform:** University website
- **Audience:** Prospective students and researchers arriving via AI-powered search
- **Scope:** Content structure and language only — not technical SEO (schema markup, page speed, crawlability)
- GEO and traditional SEO overlap but are not identical. A page that ranks well on Google may still perform poorly in AI-powered search if answers are not directly extractable

## Dimensions

### 1 — Answer clarity

Does the page directly answer questions a prospective student would ask? Are answers specific and self-contained, or are they buried inside long paragraphs? AI search engines extract and cite direct, concise answers. Vague, hedged, or conditional prose is unlikely to be surfaced.

Look for:
- Direct question-answer pairs vs. buried answers
- Sentences that stand alone as citations (no "as mentioned above" or assumed context)
- Overuse of passive voice or institutional hedging ("it may be the case that…")

### 2 — Question-aligned headings

Do the H2 and H3 headings mirror natural-language questions a student would type or speak ("How do I apply?", "What are the entry requirements for this course?") or do they use internal institutional labels ("Admissions", "Entry criteria", "Programme overview")?

AI models scan headings to build their understanding of page structure. Question-framed headings significantly improve citability.

### 3 — Entity clarity

Are all key facts stated explicitly and without ambiguity?

Check that the page clearly names:
- Institution name (not just "we" or "the university")
- Course/programme name and qualification level (BSc, MSc, etc.)
- Duration, fees, start dates — as specific values, not ranges or references to other pages
- Location (campus, city)
- UCAS code or equivalent where applicable

AI cannot infer facts that are not stated; links to "see our fees page" are invisible to AI citations.

### 4 — Specificity and citability

Does the page contain specific, verifiable figures and named claims? AI search engines prefer to cite concrete data over general statements.

Examples of weak vs. strong:
- Weak: "Applications open in autumn" → Strong: "Applications open 1 October via UCAS"
- Weak: "We have strong industry links" → Strong: "92% of graduates are in employment or further study within 15 months (HESA 2024)"
- Weak: "Our facilities are excellent" → Strong: "The School of Engineering opened a £24m specialist lab in 2023"

### 5 — Structural completeness

Does the page answer the follow-up questions a student would have after reading the headline content? Check for **Who / What / Why / How / What next** — a page that answers "What is this course?" but not "Who is it for?", "Why choose it?", "How do I apply?", or "What can I do with it?" will lose out to a page that addresses all five.

## Output format

**Overall GEO readiness:** Ready / Partial / Not ready

- **Ready** = every dimension Strong, or at most one Needs work
- **Not ready** = two or more dimensions Weak
- **Partial** = everything else

**Findings table:**

| Dimension | Rating | Finding | Recommendation |
|---|---|---|---|
| Answer clarity | | | |
| Question-aligned headings | | | |
| Entity clarity | | | |
| Specificity and citability | | | |
| Structural completeness | | | |

**Quick wins** (changes that require no structural rewrite, ordered by impact):
1. …
2. …
3. …

**Example rewrite:**
Take one specific passage from the input and rewrite it to improve GEO citability. Show before and after. Only add specific facts (dates, figures, names) that appear elsewhere in the supplied content — do not invent them. Where a specific value is needed but not supplied, use a bracketed placeholder (e.g. "Applications open [date] via UCAS") and note that the editor must fill it in.

## Notes

- Re-run this audit after making changes. GEO readiness improves iteratively.
