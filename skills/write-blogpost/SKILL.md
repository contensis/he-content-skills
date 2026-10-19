---
name: write-blogpost
description: Use when drafting a new blog post from a topic/brief, or critiquing an existing blog post draft for hook, structure, voice, clarity, narrative arc, SEO/discoverability, and takeaway/CTA quality.
---

# Write Blogpost

> Draft a new blog post from a brief, or critique an existing draft against a seven-dimension quality rubric.

## Task

This skill operates in two modes. Infer the mode from the input: a topic, brief, or outline with no existing prose → Draft; a full or partial existing post → Critique. Ask only when genuinely ambiguous.

**Mode A: Draft**
Given at minimum a topic, target audience, and goal (inform / persuade / convert / entertain), write a new blog post. Tone, target length, keywords, and an outline are optional — infer sensible defaults from the topic and audience if not given, and state what you inferred.

**Mode B: Critique**
Given an existing draft, score it against each dimension in the Rubric below and return specific, actionable fixes for anything below Pass. Do not produce a full rewritten draft — point at the weak spots and show how to fix them, in place.

## Rubric

Used to guide drafting in Mode A and to score in Mode B (✅ Pass / ⚠️ Warning / ❌ Fail):

1. **Hook/opening** — earns the next sentence in the first few lines; no throat-clearing or generic scene-setting
2. **Structure & scannability** — subheadings that orient a skimmer, short paragraphs, formatting that supports skimming without gutting the substance
3. **Voice & tone consistency** — one consistent voice throughout, matched to the stated audience
4. **Clarity & concision** — no padding, jargon is justified or explained, one idea per paragraph
5. **Narrative/argument arc** — a through-line connecting sections, not a list of disconnected points
6. **SEO/discoverability** — headings answer the questions a reader would actually search, natural (not stuffed) keyword use
7. **Clear takeaway/CTA** — the reader knows what to do or think next by the end

**Fail** = the dimension actively undermines the post (e.g. no hook, no discernible structure). **Warning** = present but weak. **Pass** = meets the bar for the stated audience and goal.

## Output format

**Mode A: Draft**

```
[The full post, in markdown, with headings]
```

Followed by:

```
Assumptions made: [tone/length/keywords/outline inferred, if any were not given]
```

**Mode B: Critique**

Summary line: `X/7 dimensions passing`

Then a table:

| Dimension | Rating | Issue | Suggested fix |
| --- | --- | --- | --- |
| Hook | ⚠️ Warning | Opens with a generic definition | Open on the specific claim or scene instead: "..." |

End with a prioritised fix list: Fails first, then Warnings.
