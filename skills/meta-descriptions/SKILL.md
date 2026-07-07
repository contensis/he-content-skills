---
name: meta-descriptions
description: Use when writing, rewriting, or reviewing meta descriptions for university web pages — SERP snippet copy for course, research, news, or policy pages, for one page or many.
---

# Meta Descriptions

> Write a consistent, on-brand meta description from web page body content.

## Task

Given the body content of a web page (or a page title plus key points), write a meta description suitable for use in the page's `<meta name="description">` tag.

If an existing meta description is supplied, first check it against the Constraints below and state whether it already **Passes** or **Needs improvement**, then propose a version to use. If it already Passes, the proposed version may be unchanged — do not rewrite a description that already meets every constraint just to show a different one.

If given multiple pages, process every page and return results in a table — none omitted, regardless of list length.

## Context

- **Platform:** University website
- **Audience:** Varies by page type — use the page content to infer (prospective students, current students, researchers, staff, general public)
- **Purpose:** The meta description appears in search engine results pages (SERPs) beneath the page title. It does not directly affect rankings, but a well-written description improves click-through rate by clearly communicating what the page contains and why it's worth visiting
- **Tone:** Matches the page type. Course pages: warm, benefit-led. Research pages: authoritative. News/events: informative. Policy/admin pages: clear and direct

## Constraints

- **Length:** 150–160 characters (including spaces). Do not go below 120 characters — short descriptions are expanded or replaced by Google with arbitrary page content
- Verify character counts with a real tool where one is available (shell `wc -c`, Python `len()`, or your platform's equivalent) — do not estimate
- Must accurately reflect the page content — do not add claims not supported by the page
- Do not use clickbait, superlatives ("the best", "world-leading") unless directly supported by evidence on the page
- Include the primary subject keyword from the page title where it fits naturally; if no title is supplied, use the primary subject inferred from the body content instead
- End with a natural call to action (e.g. "Find out more", "Explore the course", "Apply for 2026 entry") only when the page has a clear next step — course pages, event pages, application info. Purely informational pages need none
- Do not duplicate the page title verbatim
- Do not begin with the institution name unless it adds meaningful context

## Output format

**Single page:**
```
Existing description: [Pass / Needs improvement / None supplied]
Meta description: [text]
Characters: [count]
Keyword included: [yes/no — state the keyword]
CTA included: [yes/no]
Notes: [any caveats or alternatives worth considering]
```

**Multiple pages:**
| Page | Existing | Meta description | Chars | Keyword | CTA | Notes |
|------|----------|-------------------|-------|---------|-----|-------|

Flag any pages where the source content is insufficient to write an accurate description — do not fabricate.
