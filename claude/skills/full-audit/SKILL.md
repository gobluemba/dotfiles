---
name: full-audit
description: Run Adam's phased full codebase audit (Code Audit and Repair prompt pack v2) on whatever repo this session is open on. Use when the user says "run the full audit", "full audit", "audit this repo end to end", or types /full-audit. Phases 1-4 are read-only and end with a findings report. Also use when the user later approves finding IDs (e.g. "fix A-001 to A-004") to run Prompt 2, local repairs only.
---

# Full audit

The whole prompt pack is in [reference.md](reference.md), a byte-for-byte copy of
`Code-Audit-and-Repair-Prompts.md` (version 2, 2026-10-24). Read all of it before
starting. Do not work from memory of it.

## "Run the full audit" = the pack's short starter

1. Read reference.md end to end.
2. Run **Prompt 1** in READ-ONLY AUDIT mode on the repo this session is open on,
   Phases 1-4, using Modules A-D only where they apply. If no repo is open, ask
   which one.
3. Keep moving between the read-only phases without asking. Keep the coverage and
   approval ledgers. In the Claude desktop app, the task list is the progress
   tracker: one step per phase, plus the milestone percentage in your updates.
4. Stop at the end of Phase 4 with the report Prompt 1 asks for and its closing
   "Execution status" line. Nothing gets fixed in this run.

## When the user approves findings

Run **Prompt 2** for exactly the approved IDs or named batch (Phase 5: local edits,
tests, local commits only). Cleanup needs the exact items approved. Backup code
needs the ingress inventory and design confirmed first. An approval already given
is not asked for again. Phase 6 (push, PR, deploy, live checks) never starts on
its own; it needs its own explicit go-ahead.

## How this fits the standing rules

- This audit is something the user asked for by name, so the "don't run broad
  audits with no symptom" rule in `~/.claude/CLAUDE.md` does not block it.
- Read-only means read-only, even where a repo's own instructions say to run
  `git fetch`, tests, or a session-start routine first. Skip those in Phases 1-4
  and say local remote-tracking refs may be stale. Read-only remote reads that
  change nothing locally (for example `gh pr list`, `gh run list`) are fine.
- The repo's own CLAUDE.md / AGENTS.md wins where it is stricter. If it defines
  its own severity labels (for example red/yellow), show those beside the pack's
  CRITICAL / HIGH / MEDIUM. Never drop either.
- Tag every finding **Observed** (failing now, with evidence) or **Defensive** (no
  incident, could fail), per the global audit calibration rule.
- The pack's maintenance labels (red CONFIRMED / yellow LIKELY / white UNCERTAIN)
  describe evidence, not severity. Say so in the report if the repo uses the same
  colours for severity.
- On a large repo you may split Phase 2-3 areas across read-only Explore
  subagents. Re-check every finding they return against the code yourself before
  it goes in the report.
- If the session cannot finish, leave the continuation record the pack describes.
  Never call a partial audit complete.
