# sbx-kits

Sandbox kits for Claude Code: mixins that add tools, MCP servers and credentials to a sandbox.

- **[sbx-hindsight](sbx-hindsight/spec.yaml)**: per-repo long-term memory via Hindsight Cloud. Needs a key: `sbx secret set -g hindsight`.
- **[sbx-claude-dotfiles](sbx-claude-dotfiles/spec.yaml)**: your personal Claude Code config in the sandbox. Run `sbx-claude-dotfiles/sync.sh [dir]` on the host to refresh it; the source defaults to `$CLAUDE_DOTFILES_SRC`.
