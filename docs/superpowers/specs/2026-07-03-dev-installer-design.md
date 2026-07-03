# Dev installer for he-content-skills

Date: 2026-07-03

## Purpose

Make the skills in this repo available to a local Claude Code install for
development, so edits in the repo are reflected immediately without
re-installing.

## Design

A single dependency-free bash script, `install.sh`, at the repo root.

- **Default (`./install.sh`)** — for each directory under `skills/` that
  contains a `SKILL.md`, create `~/.claude/skills/<name>` as a symlink to the
  repo folder. Creates `~/.claude/skills/` if missing. Skills are discovered
  dynamically, so new skills are picked up without editing the script.
- **Idempotent** — a symlink already pointing at this repo is reported as
  "ok" and left alone; a stale symlink whose target no longer exists but that
  previously pointed into this repo path is refreshed.
- **Collisions** — a real directory, or a symlink pointing somewhere else, is
  skipped with a warning. The script never deletes anything it did not create.
- **`--uninstall`** — removes only symlinks that resolve into this repo's
  `skills/` folder.
- **`--list`** — shows each skill's state: installed / not installed /
  conflict.
- Per-skill output plus a summary line. Exits non-zero if any skill was
  skipped due to a conflict.
- The target directory can be overridden with `CLAUDE_SKILLS_DIR` (used for
  testing; defaults to `~/.claude/skills`).
- The script resolves its own location, so it works from any cwd.

## Out of scope

- Installing via the Claude Code plugin/marketplace pipeline (this repo's
  `.claude-plugin/` manifests remain the path for real installs).
- Copy-mode installs, Windows support.
