---
name: staleness-audit
description: Use when reviewing university web pages for stale or unverifiable content — fees, entry requirements, staff names, statistics, rankings, deadlines, or anything else that may have changed since the page was written.
---

# Staleness Audit

> Scan web page content and flag claims that may have become out of date, with a risk rating and reason for each flag.

## Task

Review the provided web page content and identify specific claims, data points, or references that are likely to have changed or may need verification before the page is next published or reviewed.

You are flagging, not fixing. Do not rewrite content. Do not speculate about what the correct information should be.

**Before flagging anything, anchor to today's date.** Get the actual current date from your platform or system context (e.g. environment metadata, a clock tool) — if none is available, ask the user for today's date. Do not infer it from your training data or assume it. State today's date and the current UK academic year (e.g. 2025/26) at the top of your output, and judge every dated claim relative to that anchor. A fee labelled "2024/25 entry" is stale in the 2026/27 cycle; the same fee labelled with the current cycle is not.

**Input handling:**

- Pasted plain text is the expected input — no HTML required
- If given only a URL, fetch the page if your tools allow; otherwise ask for the content to be pasted
- If the content is too partial to triage fairly (a fragment, a single section), say so and list what is missing rather than flagging it

## Context

- **Platform:** University website
- **Common staleness risks in HE content:** course fees, entry requirements, staff names and job titles, statistics (employability, rankings, REF results), accreditation status, opening hours, application deadlines, event dates, external partner names, funding bodies, policy references, software/tool names

## Constraints

- Triage from the supplied content only — do not search external sources to verify claims. The task is to flag what needs checking, not to check it
- Flag only claims with a plausible reason to have changed — do not flag stable facts (e.g. the year a building was founded, historical information)
- Treat undated claims as riskier than date-stamped ones: "92% of graduates are in employment" is a stronger flag than the same figure cited as "(HESA 2024)", because there is no way to tell which cycle it describes
- Rate each flag by risk level — see definitions below
- Do not suggest corrections — only flag and explain why the item warrants review
- If the page content appears fully current and low-risk, say so explicitly rather than inventing flags

**Risk levels** (risk = impact if wrong × likelihood of change — a clearly current-cycle fee can rate below Critical even though fees are compliance content):

| Level | Definition |
|-------|------------|
| Critical | Regulatory or compliance content — fees, entry requirements, visa/immigration information, accreditation status. Incorrect information here creates legal or reputational risk |
| High | Statistics, rankings, dated claims, named funding awards, named partners. Likely to change annually or with each cycle |
| Medium | Staff names, job titles, contact details, named software or tools. Changes with personnel or procurement |
| Low | General descriptive claims that are plausible but unverifiable without checking (e.g. "our graduates go on to…") |

## Output format

**Date anchor:**
`Reviewed [date] — current academic year [YYYY/YY]`

**Summary line:**
`[N] items flagged — [X] critical, [Y] high, [Z] medium, [W] low`

Or: `No staleness flags raised. Page content appears current and low-risk.`

**Flag table:**

| # | Location in content | Claim | Risk | Reason |
|---|---------------------|-------|------|--------|

For **Location in content**, give the nearest heading, or the first few words of the sentence if there is no heading — enough for an editor to find the claim by searching the page.

**Recommended actions:**
List Critical and High flags with a suggested owner (e.g. "confirm with Admissions team", "check against current HESA data").
