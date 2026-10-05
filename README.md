# sbx-kits

Sandbox kits for Claude Code — installable mixins that add capabilities (tools, MCP servers, credentials) to a sandbox.

## Kits

- **[sbx-hindsight](sbx-hindsight/spec.yaml)** — Long-term memory per repo via the Hindsight Coding Agents plugin, backed by Hindsight Cloud. Requires a key: `sbx secret set -g hindsight`.
- **[sbx-claude-dotfiles](sbx-claude-dotfiles/spec.yaml)** — Copies your personal Claude Code config into the sandbox via the kit's native `files/home/` tree. A sandbox can't see host paths outside the workspace, so run `sbx-claude-dotfiles/sync.sh [dir]` on the host to refresh the bundled copy whenever your dotfiles change. The source is the argument, else `$CLAUDE_DOTFILES_SRC`, else `~/dotfiles/claude/.claude`. The synced `files/` tree is gitignored. `settings.json` is installed as a managed-settings drop-in (`/etc/claude-code/managed-settings.d/50-dotfiles.json`) because `~/.claude/settings.json` is reserved by the sandbox; its keys take precedence over user settings.
