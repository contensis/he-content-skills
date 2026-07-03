#!/usr/bin/env python3
"""Build paste-ready assistant bundles from the skills in this repo.

Reads each skills/<name>/SKILL.md (plus agents/openai.yaml for display
metadata) and generates, under dist/:

  chatgpt/<name>.md          instructions to paste into a Custom GPT
  gemini-gems/<name>.md      instructions to paste into a Gemini Gem
  m365-agents/<name>/        Microsoft 365 declarative agent files
    declarativeAgent.json      (schema v1.0, instructions embedded)
    instructions.txt           (same instructions, for reference/editing)

The M365 declarative agent instructions field has an 8,000-character limit;
the script fails if any skill exceeds it.

Usage: python3 scripts/build-assistants.py
"""

import json
import re
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
SKILLS = REPO / "skills"
DIST = REPO / "dist"

M365_INSTRUCTION_LIMIT = 8000

PREAMBLE = """\
You are operating from the skill specification below. Follow it exactly.

Environment notes (this assistant runs without a developer toolchain):
- If you cannot fetch URLs, ask for the page content to be pasted instead.
- Verify character counts with code if you can run it; otherwise state
  clearly that counts are estimates.
- References to bundled example files are not available here; rely on the
  specification itself.

---
"""


def strip_frontmatter(text: str) -> str:
    if text.startswith("---\n"):
        end = text.find("\n---\n", 4)
        if end != -1:
            return text[end + 5 :].lstrip("\n")
    return text


def parse_frontmatter(text: str) -> dict:
    fields = {}
    if text.startswith("---\n"):
        end = text.find("\n---\n", 4)
        for line in text[4:end].splitlines():
            m = re.match(r"^(\w[\w-]*):\s*(.+)$", line)
            if m:
                fields[m.group(1)] = m.group(2).strip()
    return fields


def parse_openai_yaml(path: Path) -> dict:
    """Minimal parse of the three quoted interface fields (no yaml dep)."""
    fields = {}
    if path.exists():
        for key in ("display_name", "short_description", "default_prompt"):
            m = re.search(rf'{key}:\s*"([^"]*)"', path.read_text())
            if m:
                fields[key] = m.group(1)
    return fields


def conversation_starter(default_prompt: str, name: str) -> str:
    """'Use $skill-name to do X.' → 'Do X.'"""
    m = re.match(rf"Use \${re.escape(name)} to (.+)$", default_prompt)
    if not m:
        return default_prompt
    rest = m.group(1)
    return rest[0].upper() + rest[1:]


def main() -> int:
    skill_dirs = sorted(d for d in SKILLS.iterdir() if (d / "SKILL.md").is_file())
    if not skill_dirs:
        print(f"No skills found in {SKILLS}", file=sys.stderr)
        return 1

    for out in ("chatgpt", "gemini-gems", "m365-agents"):
        (DIST / out).mkdir(parents=True, exist_ok=True)

    failures = 0
    for skill_dir in skill_dirs:
        name = skill_dir.name
        raw = (skill_dir / "SKILL.md").read_text()
        front = parse_frontmatter(raw)
        body = strip_frontmatter(raw)
        meta = parse_openai_yaml(skill_dir / "agents" / "openai.yaml")

        display = meta.get("display_name", name)
        short = meta.get("short_description", front.get("description", ""))
        instructions = PREAMBLE + body

        # Paste-ready bundles for ChatGPT and Gemini Gems.
        starter = ""
        if "default_prompt" in meta:
            starter = (
                "\n\n<!-- Suggested conversation starter: "
                + conversation_starter(meta["default_prompt"], name)
                + " -->\n"
            )
        for target, label in (("chatgpt", "Custom GPT"), ("gemini-gems", "Gemini Gem")):
            out = DIST / target / f"{name}.md"
            out.write_text(
                f"<!-- {display} — paste everything below this comment block\n"
                f"     into the {label}'s instructions field. -->\n"
                f"<!-- Description field: {short} -->{starter}\n" + instructions
            )

        # Microsoft 365 declarative agent package.
        agent_dir = DIST / "m365-agents" / name
        agent_dir.mkdir(parents=True, exist_ok=True)
        if len(instructions) > M365_INSTRUCTION_LIMIT:
            print(
                f"FAIL {name}: instructions {len(instructions)} chars "
                f"exceed the M365 limit of {M365_INSTRUCTION_LIMIT}",
                file=sys.stderr,
            )
            failures += 1
            continue
        agent = {
            "$schema": "https://developer.microsoft.com/json-schemas/copilot/declarative-agent/v1.0/schema.json",
            "version": "v1.0",
            "name": display[:100],
            "description": short[:1000],
            "instructions": instructions,
        }
        (agent_dir / "declarativeAgent.json").write_text(
            json.dumps(agent, indent=2, ensure_ascii=False) + "\n"
        )
        (agent_dir / "instructions.txt").write_text(instructions)

        print(f"built {name} ({len(instructions)} chars)")

    if failures:
        print(f"{failures} skill(s) failed", file=sys.stderr)
        return 1
    print(f"\n{len(skill_dirs)} skill(s) → {DIST}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
