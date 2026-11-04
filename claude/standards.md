<!-- BEGIN standard:parallel-sessions v2 — identical in every repo. Edit the master copy in gobluemba/dotfiles (claude/standards.md), then re-sync; never edit this block in place. -->
## Parallel sessions — one writer, and decisions live in the repo

The owner often runs several Claude sessions at once: Claude Code (terminal, web and mobile),
Claude Design, Cowork, and plain chats. Each one knows only what was said in its own chat. These
rules keep them from overwriting each other, or acting on a decision another chat never heard.

1. **One writer at a time.** Only a Claude Code session changes a repository — branches,
   commits, version bumps, PRs. Design tools and Cowork sessions are read-only against the repo,
   unless this file names a folder they own.
2. **Sync before you change anything.** `git fetch`, confirm the branch and HEAD you are on, and
   read the repo's decisions file. Never switch the branch of a working tree another session may
   be using — start a separate worktree instead.
3. **Rulings live in the repo, not in chat.** When the owner rules on something during a session,
   record it in the decisions file — `docs/PRODUCT_DECISIONS.md` if it exists, otherwise create
   `docs/DECISIONS.md` — in the same PR. A ruling that exists only in a chat does not exist. If an
   instruction contradicts a recorded decision, stop and ask the owner which one stands; never
   pick one silently.
4. **No collisions on unique values.** Before claiming anything that must be unique — a cache
   version, a migration number, a release tag — check that no open PR already claims it.
5. **Leave nothing hanging.** End every session by stating what changed, what is still open, and
   where it is recorded. An unanswered question in an abandoned chat is how sessions drift apart.
6. **One working session per repo.** Only one Claude Code session at a time is a repo's writer:
   the one that commits, pushes, and opens or merges PRs. Another session may read and test the
   writer's commits and send it what it finds, but it never writes to that repo. While a PR waits
   on CI or a merge, nothing else is merged into the default branch, because each merge sends the
   waiting PR back through CI. At session start, look for another writer (other open sessions on
   the repo, open PRs, branches above the default branch); if there is one, say so and ask the
   owner which session continues. When the work moves on, finish or hand off and archive the idle
   session, with the owner's yes. (Owner, 2026-11-03: *"I should only have one session per tool
   open at any given time"*, then *"make standing rule for all repos"*.)
<!-- END standard:parallel-sessions -->

<!-- BEGIN standard:session-wrapup v1 — identical in every repo. Edit the master copy in gobluemba/dotfiles (claude/standards.md), then re-sync; never edit this block in place. -->
## Session wrap-up — tell me when it's safe to close

When this session pushes commits, opens or merges a PR, or triggers a deploy
(GitHub Actions, Railway, Render, Netlify):

1. Do NOT end the turn silently. Use the `ci-wait-notify` skill to arm a durable
   check-in that sends a push notification when the job reaches a final state
   (success, failure, cancelled, timeout). If that skill isn't available in this
   session, use whatever scheduled check-in / push-notification tool is, within
   the same limits below.
2. Budget guardrails (non-negotiable):
   - Poll no more often than every 5 minutes; stop after 6 checks (30 min max).
   - Never auto-retry, re-run, or redeploy a failed job. Report it and ask me.
   - One check-in per job; don't stack duplicate watchers.
3. When everything has landed, send ONE final message:
   - "✅ All landed — safe to close this session", followed by one line per job:
     repo · job · pass/fail · link
   - Or "⚠️ Not safe to close" with what failed or is still running.
4. If nothing was pushed or deployed: "✅ Nothing pending — safe to close."
<!-- END standard:session-wrapup -->
