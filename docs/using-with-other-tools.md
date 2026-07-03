# Using these skills with other AI tools

Every skill in this repo follows the [Agent Skills standard](https://agentskills.io) —
a folder containing a `SKILL.md` with `name` and `description` frontmatter and a
plain-markdown body. The skills are pure prompt specifications (no scripts, no
MCP dependencies), so they work in any tool that supports the standard, and can
be pasted into tools that don't.

## Tools with native Agent Skills support

`./install.sh` symlinks the skills into every supported tool found on your
machine:

| Tool | Skills directory | Notes |
|------|-----------------|-------|
| Claude Code | `~/.claude/skills/` | Also installable as a plugin via `.claude-plugin/` |
| Codex CLI (OpenAI) | `~/.agents/skills/` | Each skill ships `agents/openai.yaml` with Codex UI metadata; invoke explicitly with `$skill-name` |
| GitHub Copilot | `~/.agents/skills/` or `~/.copilot/skills/` | Works in VS Code agent mode, Copilot CLI, coding agent, and code review |
| Gemini CLI | `~/.gemini/skills/` | |

For a project-level (checked-in) install instead, copy or symlink the skill
folders into the repo you're working in: `.github/skills/` (Copilot),
`.agents/skills/` (Codex, Copilot), `.claude/skills/` (Claude Code, Copilot),
or `.gemini/skills/` (Gemini CLI).

## ChatGPT (web) and other tools without skills support

Each `SKILL.md` body is a self-contained prompt spec. Paste it into:

- **ChatGPT** — a Project's custom instructions, or a Custom GPT's
  instructions field. Then supply the page content or raw copy as your
  message.
- **Anything else** — paste the SKILL.md body as a system/custom instruction,
  or paste it above your content in a single message.

For hosted assistants — Custom GPTs, Gemini Gems, and Microsoft 365 Copilot
declarative agents — run `python3 scripts/build-assistants.py` to generate
paste-ready and deployable bundles under `dist/` with the environment caveats
below already prepended. See the README for details.

Two things to know when using them this way:

- Skills that offer to fetch URLs (staleness-audit, geo-audit) say "if your
  tools allow" — in a tool without browsing, paste the page text instead.
- Character-count verification (alt-text, meta-descriptions) expects a real
  tool — in ChatGPT this means the code interpreter (Python `len()`); if the
  tool can't run code, treat counts as estimates and say so.

## Conventions that keep the skills portable

When editing or adding skills, preserve these:

- Frontmatter uses only the core spec fields (`name`, `description`)
- No references to tool-specific features — capability checks are phrased as
  "if your tools allow" / "your platform's equivalent"
- Cross-references to sibling skills say "from this collection, if available"
- No `@`-style force-loading links; supporting files are referenced with
  relative markdown links
