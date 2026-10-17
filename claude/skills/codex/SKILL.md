---
name: codex
description: Run the OpenAI Codex CLI non-interactively for a second opinion, an independent code review, a root-cause investigation, or to hand off a self-contained coding task. Use when the user says "chiedi a codex", "codex", "second opinion", or when stuck after two failed attempts.
---

# Codex CLI

Codex runs as a plain Bash command. No wrapper, no broker, no subagent.
Sessions are kept on disk by default, so you can talk to Codex over
several turns: start one, keep its id, resume it by id.

## Commands

```bash
DIR=<scratchpad dir from the system prompt>/codex
mkdir -p "$DIR"

# First turn: start a session, read-only (default). Write the prompt to a
# file first. The log carries the session id; the reply goes to -o.
codex exec -s read-only --color never -o "$DIR/reply-1.md" \
  - < "$DIR/prompt-1.md" > "$DIR/log-1.txt" 2>&1
SESSION=$(grep -m1 -oE 'session id: [0-9a-f-]+' "$DIR/log-1.txt" | cut -d' ' -f3)
cat "$DIR/reply-1.md"

# Next turns: resume the same session by id. `resume` accepts neither
# -s nor --color: pass the sandbox with -c.
codex exec resume -c sandbox_mode='"read-only"' -o "$DIR/reply-2.md" \
  "$SESSION" - < "$DIR/prompt-2.md" > "$DIR/log-2.txt" 2>&1
cat "$DIR/reply-2.md"

# Write-capable, only when the user asked Codex to edit files:
#   new session:  -s workspace-write
#   resume:       -c sandbox_mode='"workspace-write"'

# Throwaway one-shot question that will never need a follow-up
codex exec --ephemeral -s read-only --color never -o "$DIR/once.md" "PROMPT" >/dev/null 2>&1

# review of the current git diff
codex exec review --color never 2>&1 | tail -80
```

Flags: `-m MODEL` overrides the model, `--output-schema FILE` forces a
JSON shape, `--json` streams JSONL events, `-i img.png` attaches images.
Leave model and effort to `~/.codex/config.toml` unless the user asks.

## Rules

- Keep sessions by default. Record the session id and give it to the
  user, who can continue it with `codex exec resume <id>`.
- Resume by id, never with `--last`: another Codex session in the same
  directory may be newer.
- A real task takes 1-10 minutes. Run it in the background (or with a
  600000 Bash timeout) and read the reply file when it finishes.
- Read-only sandbox unless the user explicitly wants Codex to write.
- The sandbox (Seatbelt) never restricts reads. Read-only has no network
  at all, localhost included, and no option to enable it. workspace-write
  has network via `~/.codex/config.toml`, so any task that needs the dev
  server, playwright, or the internet must run with workspace-write.
- Write the first prompt like a ticket: goal, the files or diff to look
  at, constraints and decisions already taken, what to return (findings
  with `file:line`, patch, or one-paragraph verdict). Codex sees the repo
  but not this conversation; later turns in the same session remember
  the earlier ones.
- Use the follow-up turns to challenge: ask Codex to verify a claim in
  the code, to answer an objection, or to rank its own proposals.
- Report Codex's answer as Codex's, not as verified fact. Check every
  claim that changes what you do against the code and the context
  before passing it on or acting on it.
- After a write run, inspect `git diff` (and prove that only the
  intended kind of change happened) before summarizing.
