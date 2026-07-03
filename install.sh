#!/usr/bin/env bash
#
# Dev installer for he-content-skills.
#
# Symlinks each skill in skills/ into the Agent Skills directories of the
# agent CLIs installed on this machine, so edits in this repo are live
# immediately. Default targets (chosen when the owning tool is present):
#
#   ~/.claude/skills   Claude Code            (if ~/.claude exists)
#   ~/.agents/skills   Codex CLI + Copilot    (if ~/.codex or ~/.copilot exists)
#   ~/.gemini/skills   Gemini CLI             (if ~/.gemini exists)
#
# Usage:
#   ./install.sh              install (create/refresh symlinks)
#   ./install.sh --uninstall  remove symlinks that point into this repo
#   ./install.sh --list       show the install state of each skill
#
# Override targets with SKILLS_TARGET_DIRS (space-separated list), or
# CLAUDE_SKILLS_DIR to target a single directory (used for testing).

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_SRC="$REPO_DIR/skills"

if [ -n "${SKILLS_TARGET_DIRS:-}" ]; then
  # Intentional word-splitting of the override list.
  # shellcheck disable=SC2206
  TARGET_DIRS=(${SKILLS_TARGET_DIRS})
elif [ -n "${CLAUDE_SKILLS_DIR:-}" ]; then
  TARGET_DIRS=("$CLAUDE_SKILLS_DIR")
else
  TARGET_DIRS=()
  [ -d "$HOME/.claude" ] && TARGET_DIRS+=("$HOME/.claude/skills")
  if [ -d "$HOME/.codex" ] || [ -d "$HOME/.copilot" ]; then
    TARGET_DIRS+=("$HOME/.agents/skills")
  fi
  [ -d "$HOME/.gemini" ] && TARGET_DIRS+=("$HOME/.gemini/skills")
  if [ ${#TARGET_DIRS[@]} -eq 0 ]; then
    echo "No supported agent CLI found (~/.claude, ~/.codex, ~/.copilot, ~/.gemini)." >&2
    echo "Set SKILLS_TARGET_DIRS to install anyway." >&2
    exit 1
  fi
fi

mode="install"
case "${1:-}" in
  "") ;;
  --uninstall) mode="uninstall" ;;
  --list)      mode="list" ;;
  -h|--help)   sed -n '2,20p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
  *) echo "Unknown option: $1 (try --help)" >&2; exit 2 ;;
esac

# Portable readlink -f (macOS ships without it on older systems).
resolve() {
  local p="$1"
  while [ -L "$p" ]; do
    local link
    link="$(readlink "$p")"
    case "$link" in
      /*) p="$link" ;;
      *)  p="$(dirname "$p")/$link" ;;
    esac
  done
  echo "$p"
}

# A symlink is "ours" if its target is inside this repo's skills/ folder,
# even if the target no longer exists (stale link after a repo move).
is_ours() {
  local link_target
  link_target="$(readlink "$1")"
  case "$link_target" in
    "$SKILLS_SRC"/*) return 0 ;;
    *) return 1 ;;
  esac
}

skills=()
for dir in "$SKILLS_SRC"/*/; do
  [ -f "$dir/SKILL.md" ] && skills+=("$(basename "$dir")")
done

if [ ${#skills[@]} -eq 0 ]; then
  echo "No skills found in $SKILLS_SRC" >&2
  exit 1
fi

conflicts=0
changed=0

for TARGET_DIR in "${TARGET_DIRS[@]}"; do
  echo "→ $TARGET_DIR"

  for name in "${skills[@]}"; do
    src="$SKILLS_SRC/$name"
    dest="$TARGET_DIR/$name"

    case "$mode" in
      list)
        if [ -L "$dest" ] && [ "$(resolve "$dest")" = "$src" ]; then
          echo "installed      $name"
        elif [ -e "$dest" ] || [ -L "$dest" ]; then
          echo "conflict       $name ($dest exists and is not ours)"
          conflicts=$((conflicts + 1))
        else
          echo "not installed  $name"
        fi
        ;;

      install)
        mkdir -p "$TARGET_DIR"
        if [ -L "$dest" ]; then
          if [ "$(resolve "$dest")" = "$src" ]; then
            echo "ok        $name"
          elif is_ours "$dest"; then
            ln -sfn "$src" "$dest"
            echo "refreshed $name"
            changed=$((changed + 1))
          else
            echo "skipped   $name (symlink points elsewhere: $(readlink "$dest"))" >&2
            conflicts=$((conflicts + 1))
          fi
        elif [ -e "$dest" ]; then
          echo "skipped   $name ($dest exists and is not a symlink)" >&2
          conflicts=$((conflicts + 1))
        else
          ln -s "$src" "$dest"
          echo "installed $name"
          changed=$((changed + 1))
        fi
        ;;

      uninstall)
        if [ -L "$dest" ] && is_ours "$dest"; then
          rm "$dest"
          echo "removed   $name"
          changed=$((changed + 1))
        elif [ -e "$dest" ] || [ -L "$dest" ]; then
          echo "skipped   $name (not managed by this repo)" >&2
          conflicts=$((conflicts + 1))
        else
          echo "absent    $name"
        fi
        ;;
    esac
  done

  # Prune links left behind by skills that were renamed or deleted in the
  # repo: ours, but dangling. Links to targets that still exist are left alone.
  if [ -d "$TARGET_DIR" ]; then
    for dest in "$TARGET_DIR"/*; do
      [ -L "$dest" ] || continue
      is_ours "$dest" || continue
      [ -e "$dest" ] && continue
      name="$(basename "$dest")"
      if [ "$mode" = "list" ]; then
        echo "orphaned       $name (target gone: $(readlink "$dest"))"
      else
        rm "$dest"
        echo "pruned    $name"
        changed=$((changed + 1))
      fi
    done
  fi

  echo
done

echo "$mode: ${#skills[@]} skill(s) × ${#TARGET_DIRS[@]} target(s), $changed changed, $conflicts conflict(s)"
[ "$conflicts" -eq 0 ]
