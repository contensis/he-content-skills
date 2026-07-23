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
can AI-powered search engines (ChatGPT Search, Perplexity, Google AI Overviews)
understand, cite, and surface it? Produces ratings, quick wins, and an example
rewrite.

### ✂️ `meta-descriptions`

Write, rewrite, or review SERP meta descriptions — course, research, news, or
policy pages, one page or many. Enforces length limits with real character
counts.

### 📝 `refine-for-web`

Turn raw submitted copy — Word documents, emails, pasted text from faculties or
departments — into structured, web-ready course page content. Preserves entry
requirements and fees verbatim, tags claims needing verification, and applies
GEO principles (question-form headings, explicit entity facts).
Worked example: [input](skills/refine-for-web/examples/input-01.txt) →
[output](skills/refine-for-web/examples/output-01.md).

### ⏳ `staleness-audit`

Scan page content and flag claims that may be out of date — fees, entry
requirements, staff names, statistics, deadlines — anchored to today's date and
the current academic year, with a risk rating and reason per flag.

## Agents (Claude Code plugin only)

Unlike the skills above, these are Claude Code subagents ([agents/](agents/)) —
not portable prompt specs, since they rely on Claude Code's Agent tool to fan
out work in parallel. Installed automatically with the Claude Code plugin.

### `geo-audit-batch`

Scans many university web pages for GEO readiness in one pass — course,
research, news, or policy pages: takes a list of URLs or a sitemap, dispatches
a `geo-audit-page` subagent per page in parallel, then returns a cross-page
summary (readiness distribution, recurring weak dimensions, a worst-first
worklist) plus the full per-page findings.

### `geo-audit-page`

Audits a single page against the `geo-audit` skill's five dimensions. Used
internally by `geo-audit-batch`; can also be invoked directly for one page.

### `staleness-audit-batch`

Scans many university web pages for stale or unverifiable content in one
pass — fees, entry requirements, staff names, statistics, deadlines: takes a
list of URLs or a sitemap, establishes a single date anchor for the whole
batch, dispatches a `staleness-audit-page` subagent per page in parallel, then
returns a cross-page summary (flag totals by risk, pages with Critical issues,
a worst-first worklist) plus the full per-page flags.

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
.claude-plugin/         Claude Code plugin + marketplace manifests
scripts/
  build-assistants.py   generates dist/ assistant bundles
install.sh              multi-tool dev installer (symlinks)
docs/
  using-with-other-tools.md   per-tool usage + portability conventions
```

## Adding or editing a skill

- Folder name, `name:` frontmatter, and H1 title stay in sync;
  `description:` starts with "Use when…" and states triggers, not workflow
- Keep skills tool-agnostic — see the conventions in
  [docs/using-with-other-tools.md](docs/using-with-other-tools.md)
- Add `agents/openai.yaml` with `display_name`, `short_description`, and a
  `default_prompt` using the `$skill-name` convention
- Rerun `./install.sh` (it prunes symlinks for renamed/deleted skills) and
  `python3 scripts/build-assistants.py`
- Update the skill list in this README and, if the plugin summary changes,
  the descriptions in `.claude-plugin/`
