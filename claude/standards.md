<!-- BEGIN standard:parallel-sessions v1 — identical in every repo. Edit the master copy in gobluemba/dotfiles (claude/standards.md), then re-sync; never edit this block in place. -->
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
<!-- END standard:parallel-sessions -->
