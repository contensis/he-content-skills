---
name: alt-text
description: Use when writing alt text for new images or auditing existing alt text for WCAG 2.2 AA accessibility compliance on university web pages — single images, image lists, page URLs, or pasted markup.
---

# Generate & Audit Alt Text

> Write meaningful alt text for images, or audit existing alt text against WCAG 2.2 AA standards and flag issues with suggested fixes.

## Task

This skill operates in two modes. Infer the mode from the input: existing alt text (or markup containing alt attributes) → Audit; an image or image description with no existing alt text → Generate. Ask only when genuinely ambiguous.

**Mode A: Generate**
Given a description of an image (or the image itself, if your platform supports it), write appropriate alt text.

**Mode B: Audit**
Given a list of images with their existing alt text (or lack of it), a page URL, or pasted markup, audit each against WCAG 2.2 AA and return a structured report.

## Context

- **Standard:** WCAG 2.2 AA
- **Platform:** University website. Images may include campus photography, student/staff portraits, research imagery, events, illustrations, icons, charts, and diagrams
- **Purpose of alt text:** To convey the meaning or function of an image to someone who cannot see it — not to describe every visual detail, but to communicate what matters in context

## Constraints

**For all alt text:**

- Do not begin with "Image of", "Photo of", "Picture of", or similar — screen readers already announce the element as an image
- Maximum 125 characters for standard alt text
- Verify character counts with a real tool where one is available (shell `wc -c`, Python `len()`, or your platform's equivalent) — do not estimate
- Only describe what the image or its description actually shows — do not invent visual detail. Flag any alt text you could not write accurately without seeing the image
- For functional images (inside a link or button), describe the destination or action (e.g. "Book an undergraduate open day"), not the image's appearance
- Decorative images (purely visual, no informational content) should use empty alt text: `alt=""` — do not write "decorative" or "decorative image"
- If an image contains text, that text must be included in the alt text (or rendered as real text instead)
- For complex images (charts, graphs, infographics, diagrams), alt text should summarise the key finding or message; provide a longer description separately as adjacent visible text, `aria-describedby`, or a linked long description (do not use `longdesc` — it is obsolete and unsupported)

**For Mode B (Audit):**

- Rate each item: ✅ Pass / ⚠️ Warning / ❌ Fail
- Fail = missing alt text on a non-decorative image, or alt text that conveys no meaning
- Warning = alt text present but suboptimal (too long, starts with "image of", describes appearance rather than meaning, redundant with adjacent text, or describes a linked image's appearance rather than the link's purpose)
- Pass = appropriate alt text for the image type and context

## Output format

**Mode A: Generate**

```
Alt text: [your alt text here]
Characters: [count]
Notes: [any caveats — e.g. "confirm the name of the person pictured before publishing"]
```

**Mode B: Audit**
Summary line: `X images reviewed — ❌ Y fail, ⚠️ Z warnings, ✅ W pass`

Then a table, using the icons in the Rating column (✅ Pass, ⚠️ Warning, ❌ Fail):

| #   | Image / location | Existing alt text | Rating     | Issue | Suggested fix |
| --- | ---------------- | ----------------- | ---------- | ----- | ------------- |
| 1   | hero-campus.jpg  | "image of campus" | ⚠️ Warning | Starts with "image of" | "Aerial view of the Riverside campus at dusk" |

End with a prioritised fix list: Fails first, then Warnings.
