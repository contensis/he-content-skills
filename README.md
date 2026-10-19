<p align="center">
  <img src="assets/icon.svg" alt="HE Content Skills logo: a graduation mortarboard resting on a fountain-pen nib" width="128">
</p>

# HE Content Skills

[![skills.sh](https://skills.sh/b/contensis/he-content-skills)](https://skills.sh/contensis/he-content-skills)

Agent skills for higher-education web content teams: writing, auditing, and
refining university website content with AI assistance.

Each skill follows the [Agent Skills standard](https://agentskills.io) — a
folder containing a `SKILL.md` with `name`/`description` frontmatter and a
plain-markdown specification. The skills are pure prompt specs (no scripts, no
external dependencies), so they run in any tool that supports the standard and
can be pasted into ones that don't.

## Skills

### ♿ `alt-text`

Write alt text for new images, or audit existing alt text against WCAG 2.2 AA —
single images, image lists, page URLs, or pasted markup. Two modes (Generate /
Audit), inferred from the input.

### 🔎 `geo-audit`

Audit a page against five GEO (Generative Engine Optimization) dimensions —
can AI-powered search engines (ChatGPT Search, Perplexity, Google AI Overviews,
Bing Copilot) understand, cite, and surface it? Produces ratings, quick wins,
and an example rewrite.

### 🎓 `graduate-outcomes`

Write or refresh a course page's careers/graduate-outcomes section — roles,
sectors, salary, and further-study routes. Searches supplied content and, where
the tool allows, the web (HESA/Discover Uni, Prospects.ac.uk, LMI For All);
tags sourced and inferred claims separately and never fabricates stats,
employers, or alumni. Worked example: [input](skills/graduate-outcomes/examples/input-01.txt) →
[output](skills/graduate-outcomes/examples/output-01.md).

### ✂️ `meta-descriptions`

Write, rewrite, or review SERP meta descriptions — course, research, news, or
policy pages, one page or many. Enforces length limits with real character
counts.

### 📝 `refine-for-web`

Turn raw submitted copy — Word documents, emails, pasted text from faculties or
departments — into structured, web-ready page content, typically course pages.
Preserves entry requirements and fees verbatim, tags claims needing
verification, and applies GEO principles (question-form headings, explicit
entity facts).
Worked example: [input](skills/refine-for-web/examples/input-01.txt) →
[output](skills/refine-for-web/examples/output-01.md).

### ⏳ `staleness-audit`

Scan page content and flag claims that may be out of date — fees, entry
requirements, staff names, statistics, deadlines — anchored to today's date and
the current academic year, with a risk rating and reason per flag.

### 🌐 `website-audit`

Crawl a section of a university website — e.g. `/courses` or a department's
pages — and audit it against eight criteria: brand, quality, accessibility,
GDPR/privacy policy, ownership, freshness, audience/analytics access, and
duplication with the rest of the site. Rated Red/Amber/Green, or Not assessed
where the evidence wasn't available.

### ✍️ `write-blogpost`

Draft a new blog post from a topic/audience/goal brief, or critique an
existing draft against a seven-dimension rubric (hook, structure, voice,
clarity, narrative arc, SEO/discoverability, takeaway/CTA). Unlike the rest of
this collection, not scoped to HE content.

## Agents (Claude Code plugin only)

Unlike the skills above, these are Claude Code subagents ([agents/](agents/)) —
not portable prompt specs, since they rely on Claude Code's Agent tool to fan
out work in parallel. Installed automatically with the Claude Code plugin.

### `geo-audit-batch`

Audits many pages for GEO readiness in one pass. Takes a list of URLs or a
sitemap, runs a `geo-audit-page` subagent per page in parallel, and returns a
cross-page summary — readiness distribution, recurring weak dimensions, pages
with possible JavaScript rendering issues, a worst-first worklist — plus the
full per-page findings.

### `geo-audit-page`

Audits a single page against the `geo-audit` skill's five dimensions. Used
internally by `geo-audit-batch`; can also be invoked directly for one page.

### `staleness-audit-batch`

Audits many pages for stale or unverifiable content in one pass. Takes a list
of URLs or a sitemap, sets one date anchor for the whole batch, runs a
`staleness-audit-page` subagent per page in parallel, and returns a cross-page
summary — flag totals by risk, pages with Critical issues, a worst-first
worklist — plus the full per-page flags.

### `staleness-audit-page`

Audits a single page against the `staleness-audit` skill, given a date anchor.
Used internally by `staleness-audit-batch`; can also be invoked directly for
one page.

## Installing

### Dev install (symlinks, edits live immediately)

```bash
./install.sh          # install into every supported tool found on this machine
./install.sh --list   # show install state
./install.sh --uninstall
```

The installer detects which agent CLIs are present and symlinks the skills into
each one's Agent Skills directory:

| Tool | Skills directory |
|------|-----------------|
| Claude Code | `~/.claude/skills/` |
| Codex CLI + GitHub Copilot | `~/.agents/skills/` (shared standard location) |
| Gemini CLI | `~/.gemini/skills/` |

### Claude Code plugin

The repo doubles as a Claude Code plugin marketplace
([.claude-plugin/](.claude-plugin/)): add it with `/plugin marketplace add` and
install `he-content-skills`.

### GitHub Copilot CLI

Copilot CLI reads the same `.claude-plugin/` marketplace, so you can install
the skills without cloning the repo:

```bash
copilot plugin marketplace add contensis/he-content-skills
copilot plugin install he-content-skills@he-content
```

If you've cloned the repo, `./install.sh` symlinks the skills into
`~/.agents/skills/` instead (when `~/.copilot` exists), and edits apply right
away.

In a Copilot session, `/skills list` shows the installed skills and
`/skills reload` picks up changes. Copilot chooses a skill from its
description, or you can name one with a slash, e.g. "Use the /geo-audit skill
on https://www.example.ac.uk/courses/history".

Only the skills work in Copilot CLI. The batch and page agents above are
Claude Code subagents.

### Hosted assistants (Custom GPTs, Gemini Gems, Microsoft 365 Copilot)

```bash
python3 scripts/build-assistants.py
```

generates paste-ready and deployable bundles under `dist/` (not committed):

- `dist/chatgpt/<skill>.md` — paste into a Custom GPT's instructions field
  (fits the 8,000-character limit), with a suggested conversation starter
- `dist/gemini-gems/<skill>.md` — paste into a Gem at gemini.google.com/gems
  (Google offers no official Gems API, so creation is manual)
- `dist/m365-agents/<skill>/` — a [declarative agent](https://learn.microsoft.com/en-us/microsoft-365-copilot/extensibility/declarative-agent-manifest-1.0)
  `declarativeAgent.json` + `instructions.txt`, deployable via the Microsoft
  365 Agents Toolkit or adaptable in Copilot Studio

Each bundle prepends an environment preamble (ask for pasted content instead
of fetching; flag estimated character counts) suited to hosted chat assistants.

## Repository layout

```
skills/<name>/
  SKILL.md              the skill (Agent Skills standard)
  agents/openai.yaml    Codex UI metadata (display name, $skill-name prompt)
  examples/             worked input → output pairs (where present)
agents/                 Claude Code subagents (batch/page audits)
.claude-plugin/         Claude Code plugin + marketplace manifests
scripts/
  build-assistants.py   generates dist/ assistant bundles
install.sh              multi-tool dev installer (symlinks)
docs/
  adr/                        architecture decision records
  using-with-other-tools.md   per-tool usage + portability conventions
CONTEXT.md              glossary of terms and skill boundaries
```

## Adding or editing a skill

- Folder name, `name:` frontmatter, and H1 title stay in sync. Frontmatter
  holds only `name` and `description`; `description` starts with "Use when…"
  and states triggers, not workflow
- Keep skills tool-agnostic — see the conventions in
  [docs/using-with-other-tools.md](docs/using-with-other-tools.md)
- Keep each skill standalone — no links or references to ADRs, `docs/`,
  other skills, or repo files outside the skill's own folder, since installed
  copies and hosted-assistant bundles only carry the skill itself. Record the
  reasoning in `docs/adr/` and `CONTEXT.md` instead
- Add `agents/openai.yaml` with `display_name`, `short_description`, and a
  `default_prompt` using the `$skill-name` convention
- Rerun `./install.sh` (it prunes symlinks for renamed/deleted skills) and
  `python3 scripts/build-assistants.py`, which fails if a skill exceeds the
  8,000-character hosted-assistant limit
- Update the skill list in this README and, if the plugin summary changes,
  the descriptions in `.claude-plugin/`
