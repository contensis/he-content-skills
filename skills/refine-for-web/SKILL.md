---
name: refine-for-web
description: Use when refining raw submitted copy — Word documents, emails, or pasted text from faculty, departments, or professional services — into structured, web-ready university website content, typically course pages aimed at prospective students.
---

# Refine for Web

> Turn raw submitted text — from faculty, departments, or professional services — into structured, web-ready content for a university website.

> Worked example: [examples/input-01.txt](examples/input-01.txt) → [examples/output-01.md](examples/output-01.md)

## Task

Produce clean, structured, publishable web copy from unstructured source content.

**Input handling:**

- If given a URL or a file path, fetch or read it if your tools allow; otherwise ask for the content to be pasted
- The suggested sections below assume course copy. For other page types (news items, staff profiles, research pages), keep the same tone, constraints, and tags, and choose section headings that fit the content

## Context

- **Audience:** Prospective undergraduate students aged 17–19, unless the source content indicates a different audience (e.g. postgraduate, CPD, research)
- **Tone:** Warm, direct, plain English. Active voice. Second person ("you will", "you'll study"). Benefit-led rather than institution-led
- **Reading level:** Flesch-Kincaid Grade 10 or below
- **Purpose:** Help prospective students understand what a course involves, whether it's right for them, and how to apply

## Constraints

- Verify character counts (page title, meta description) with a real tool where one is available (shell `wc -c`, Python `len()`, or your platform's equivalent) — do not estimate
- Verify reading level with a real readability calculation where one is available (e.g. a Flesch-Kincaid library or formula) rather than eyeballing it; if no tool is available, favour shorter sentences and common words over guessing at a grade level
- Do not invent or infer course details not present in the source (e.g. duration, start dates, class sizes) — tag them [MISSING]
- Preserve the wording, order, and every grade, subject, and value of entry requirements exactly as provided; format them as a bulleted list
- Preserve all fee amounts and their cycle labels (e.g. "2025/26") exactly as provided
- Do not use unexplained acronyms or jargon — expand on first use (e.g. "Institution of Environmental Sciences (IES)")
- Do not use phrases like "world-class", "cutting-edge", or "unique" without specific supporting evidence in the source
- Do not silently drop source content. Accreditation, staff research strengths, and industry links matter to applicants — work them into the body or introduction. Anything you do leave out (e.g. unsupported reputation claims) must be named in the review checklist under "Omitted from copy"
- Name the institution in full at first mention — AI search cannot attribute facts to "we" or "the university"; "we/our" is fine thereafter. Use `[University]` where the name isn't in the source
- State these entity facts as explicit values: course name and qualification level, duration, start date, campus/location, UCAS code, fees. Tag any the source doesn't supply [MISSING]

**Inline tags** — append in body copy immediately after the item. Keep the page title and meta description tag-free; cover their issues in the review checklist instead:

| Tag | Meaning |
|-----|---------|
| [VERIFY] | Factual claim needing verification before publishing — statistics, rankings, staff names and titles, funding awards, accreditation status. State what to confirm, and keep the source's date-stamp if it has one |
| [CHECK] | Time-sensitive content that may be right today but needs confirming for the publication cycle — field trip destinations, fee-cycle labels, event dates |
| [MISSING] | Information the page needs that is not present in the source |

## Output format

Deliver as a single markdown document with these fields in order:

**Page title (`#` H1)**
Max 60 characters. Should name the course and level clearly. Give the character count in italics on the line below, e.g. `*(25 chars ✓)*`.

**Meta description**
A bold-labelled line (`**Meta description:**`) — a CMS field, not page copy. 150–160 characters; do not go below 120 — short descriptions are expanded or replaced by Google with arbitrary page content. Summarise the course and its appeal with a natural hook. Append the character count in italics.

**Introduction paragraph**
Plain prose, 50–80 words. What the course is, why it's worth studying, what makes this institution's version distinctive (if the source supports it — accreditation counts). No bullet points.

**Body sections (`##` H2)**
Include only sections the source supports. Prefer the question-form headings where they read naturally — AI search engines extract answers more reliably from question-aligned headings; the declarative forms are acceptable fallbacks:
- What will you study? / What you'll study
- How will you learn? / How you'll learn
- Where can it take you? / Where it can take you
- What are the entry requirements? / Entry requirements
- Fees and funding

Separate the page copy above from the fields below with a horizontal rule (`---`) — they are editor-facing, not page copy.

**Suggested image alt text**
If the source includes image descriptions or context, provide suggested alt text (max 125 characters, no "Image of" prefix). If there is no image context, tag the field [MISSING].

**Review checklist**
Last field, listing:
- Every [VERIFY], [CHECK], and [MISSING] item from the copy above, each with what to confirm and with whom where obvious
- **Omitted from copy:** any source content deliberately left out, with the reason — so the department can see nothing was lost silently
