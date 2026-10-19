---
name: geo-audit
description: Use when auditing university web page content against GEO dimensions — whether AI-powered search engines (ChatGPT Search, Perplexity, Google AI Overviews, Bing Copilot) can understand, cite, and surface it to prospective students or researchers.
---

# GEO Audit

> Assess whether a web page is structured so AI-powered search engines can understand, cite, and surface it.

## Task

Given the full text content of a single web page — headings, body copy, any FAQs, plus the page title and any visible metadata (meta description, if known) — audit it against the five GEO dimensions below. For each dimension, give a rating of **Strong**, **Needs work**, or **Weak**, a one-sentence finding, and a specific recommendation. Every finding must quote or point to the specific text it's judging — a finding that could apply to any page on any topic is not acceptable.

- **Strong** = the dimension is fully addressed; an AI search engine could extract and cite this content with no changes
- **Needs work** = the dimension is partially addressed — some of the page meets it, some doesn't, or it works but not consistently
- **Weak** = the dimension is largely absent or actively hurts citability

**Input handling:**

- Pasted plain text is the expected input — no HTML required
- If given only a URL, fetch the page if your tools allow; otherwise ask for the content to be pasted
- If the content is too partial to audit fairly (a fragment, a single section), say so and list what is missing rather than rating it
- If a fetched page is missing sections you would expect (fees, modules, entry requirements), they may sit in tabs or accordions loaded by JavaScript. Flag a possible rendering issue and ask for pasted content rather than rating those facts as absent. Note that many AI crawlers may not see that content either
- If pasted plain text has no clear heading markers, infer headings from short standalone lines that introduce a following paragraph or list; if headings can't be distinguished from body copy with reasonable confidence, say so and ask for headings to be marked (e.g. with `##` or a trailing colon) rather than guessing at Dimension 2

## Context

- **Platform:** University website
- **Audience:** Prospective students and researchers arriving via AI-powered search
- **Scope:** Content structure and language only — not technical SEO (schema markup, page speed, crawlability)
- GEO and traditional SEO overlap but are not identical. A page that ranks well on Google may still perform poorly in AI-powered search if answers are not directly extractable
- **Write for people, not models.** Google advises against breaking pages into bite-sized chunks for LLMs, and citation-targeted rewrites can make a page harder to find. Never recommend fragmenting prose into disconnected Q&A, repeating keywords, or adding unverified statistics

## Dimensions

### 1 — Answer clarity

Does the page directly answer questions a prospective student would ask? Are answers specific and self-contained, or are they buried inside long paragraphs? Relevance to the question asked is the most reliable driver of AI citation; vague, hedged, or conditional prose is unlikely to be surfaced.

Look for:
- Direct answers near the top of the relevant section vs. buried answers
- Sentences that stand alone as citations (no "as mentioned above" or assumed context)
- Overuse of passive voice or institutional hedging ("it may be the case that…")

### 2 — Question-aligned headings

Do the H2 and H3 headings match what a student is asking, or do they use internal institutional labels ("Programme overview", "Key information", "Further details")? A natural-language question ("How do I apply?") is one way to match; a clear, specific label ("Entry requirements for 2027") is equally good. Rate down vague or internal labels, not the absence of question marks.

### 3 — Entity clarity

Are all key facts stated explicitly and without ambiguity? Check that the page clearly names the institution (not just "we" or "the university") and the facts for its page type:

- **Course:** course name and qualification (BSc, MSc), entry year, duration, fees, start date, campus/city, UCAS code or equivalent
- **Research/profile:** person's name and role, department, research areas, named projects or outputs
- **News:** publication date, named people and organisations, concrete outcome
- **Policy:** who it applies to, effective date, owner, last-reviewed date

State key facts on the page itself. AI search may follow links to other pages, but a "see our fees page" link is extracted far less reliably than the fact stated in place.

### 4 — Specificity and citability

Does the page contain specific, verifiable figures and named claims? AI search engines prefer to cite concrete data over general statements. Explicit dates and prices matter most for time-sensitive questions such as fees, deadlines and entry requirements, so check that time-bound facts carry a year and the page shows when it was last reviewed. (Whether those facts are still current is `staleness-audit`'s job.)

Examples of weak vs. strong:
- Weak: "Applications open in autumn" → Strong: "Applications for 2027 entry open 1 October via UCAS"
- Weak: "We have strong industry links" → Strong: "92% of graduates are in employment or further study 15 months after graduating (HESA Graduate Outcomes, 2021/22 graduates)"
- Weak: "Our facilities are excellent" → Strong: "The School of Engineering opened a £24m specialist lab in 2023"

### 5 — Structural completeness

Does the page answer the follow-up questions a reader would have after the headline content? Check for **Who / What / Why / How / What next**. For a course: "Who is it for?", "Why choose it?", "How do I apply?", "What can I do with it?". For other page types, adapt (e.g. a policy: who it covers, what it requires, how to comply, who to contact). A page that answers all five will beat one that answers only "What is this?".

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
Take one specific passage from the input and rewrite it to improve GEO citability while keeping it readable prose for people. Show before and after. Only add specific facts (dates, figures, names) that appear elsewhere in the supplied content — do not invent them. Where a specific value is needed but not supplied, use a bracketed placeholder (e.g. "Applications open [date] via UCAS") and note that the editor must fill it in.

## Notes

- Re-run this audit after making changes. GEO readiness improves iteratively.
- This audit measures content quality, not actual citation. AI answers vary between runs and engines, so to check real visibility, try 3–5 phrasings of the target question several times each on more than one engine, before and after editing.
