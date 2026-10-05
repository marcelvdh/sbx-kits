#!/usr/bin/env bash
# Refreshes this kit's files/ tree from a Claude config directory.
# Run on the host (the source directory is not visible inside a sandbox):
#
#   ./sync.sh [SOURCE_DIR]
#
# SOURCE_DIR defaults to $CLAUDE_DOTFILES_SRC, then $HOME/dotfiles/claude/.claude
# (a GNU stow package named "claude"). Not ~/.claude itself: that is live state.
set -euo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
src="${1:-${CLAUDE_DOTFILES_SRC:-$HOME/dotfiles/claude/.claude}}"

if [ ! -d "$src" ]; then
  echo "sync.sh: source directory '$src' not found;" \
    "pass it as an argument or set CLAUDE_DOTFILES_SRC" >&2
  exit 1
fi

# settings.json goes to a managed-settings drop-in (see spec.yaml), and runtime
# state and credentials never belong in a kit, even if they ended up in the
# source directory.
excludes=(
  settings.json .credentials.json history.jsonl projects sessions session-env
  shell-snapshots todos statsig cache backups downloads ide
  plugins/cache plugins/repos '*.hindsight-backup' .DS_Store
)
tar_args=()
for e in "${excludes[@]}"; do tar_args+=("--exclude=./$e"); done

claude="$here/files/home/.claude"
staged="$here/files/home/.claude-dotfiles"
rm -rf "$claude" "$staged"
mkdir -p "$claude"
tar -C "$src" "${tar_args[@]}" -c . | tar -x -C "$claude"

if [ -f "$src/settings.json" ]; then
  mkdir -p "$staged"
  cp "$src/settings.json" "$staged/settings.json"
fi

echo "Synced $(find "$here/files" -type f | wc -l | tr -d ' ') files from $src"
