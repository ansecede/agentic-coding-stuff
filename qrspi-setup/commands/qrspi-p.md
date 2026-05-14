---
name: qrspi-p
description: Run the QRSPI Plan phase to produce a tactical, testable implementation plan for one vertical slice. Use after structure-outline.md exists to create docs/sessions/{session-id}/plan/slice-{phase}.md.
---

# QRSPI — Plan Phase

**Purpose:** Produce a concrete, implementable plan for one vertical slice. Tactical and specific — this is what the implementer follows.

**Usage:** `/qrspi-p [session-id] [phase-number]`
Example: `/qrspi-p 001-user-auth 1`

---

## Session & Phase Check

1. Parse $ARGUMENTS as `[session-id] [phase-number]`. If either is missing, ask: *"Please provide session ID and phase number (e.g. `001-user-auth 1`)."* Stop and wait.
2. Set `SESSION_DIR=docs/sessions/[session-id]` and `PHASE=[phase-number]`.
3. If `structure-outline.md` is missing, tell the human and stop.
4. If `plan/slice-[PHASE].md` already exists, warn and ask whether to overwrite.

---

## Context Load

5. Read `$SESSION_DIR/structure-outline.md`. Focus only on the phase indicated.
6. Read `$SESSION_DIR/design.md` for architectural context.
7. If `docs/adr/` contains any `*.md` files (other than `ADR-FORMAT.md`), read them. All implementation decisions must conform.
8. If `docs/adr/patterns.md` exists, read it. All code written in this slice must follow established conventions.

---

## Plan Protocol

9. Confirm you understand Phase [PHASE]: restate its goal and deliverable in 2 sentences. Ask the human to validate before continuing.

10. Write user stories for this slice. Stories should be **extensive** — cover all aspects of the behavior, including edge cases, error states, and non-happy paths. Format: *As a [role], I want [capability] so that [benefit].*

11. Break each story into tasks. **Size each task around a deep module** — a unit that encapsulates meaningful behavior behind a clean, testable interface. Ask yourself: can this be tested in isolation? Does it have a clear input/output contract? If a task would touch too many concerns at once, split it. If it's a trivial wrapper with no real logic, merge it with its neighbor. The goal is a series of tasks that each produce something independently verifiable, not a line-count target.

12. For each task, specify: what to build, what to mock/stub for missing dependencies, and the acceptance criterion (the test that proves it works).

13. **TDD is non-negotiable for unit tests.** Every task that produces a unit-testable module must be marked `[TDD]` and tests are written before the implementation. Follow the `tdd` skill; do not repeat its contents here. For integration and E2E tasks, note the testing approach explicitly.

14. Flag explicit human checkpoints — moments where the human should verify behavior before the next task begins.

---

## Iteration Reminder

15. Finishing the plan does **not** trigger implementation. The human may refine stories, reorder tasks, or challenge scope. Stay in Plan until told to proceed.

---

## Output

16. Create `$SESSION_DIR/plan/` if it doesn't exist.
17. Write `$SESSION_DIR/plan/slice-[PHASE].md`:

```markdown
# Plan — Phase [N]: [Phase Name]

**Session:** [NNN-short-description]
**Date:** [today]
**Slice goal:** [One sentence]

## User Stories
- [ ] **US-[N].1** — As a [role], I want [capability] so that [benefit].
- [ ] **US-[N].2** — ...

## Tasks

### US-[N].1 — [Story title]

#### Task 1 — [Module name] [TDD]
- **Build:** [What this module does and its interface]
- **Mock:** [What dependencies are stubbed]
- **Acceptance:** [The test that proves it works]

#### Task 2 — [Module name] [TDD]
...

---
⚑ **Checkpoint** — Verify [observable behavior] before proceeding.
---

## Dependencies on Future Phases
[What this slice intentionally defers and what mock/stub represents it]
```

18. Update `$SESSION_DIR/plan/index.md` (create if needed) adding a row for this slice:

```markdown
## Slice Tracker — [NNN-short-description]

| Slice | Goal | Done | Reviewed |
|---|---|---|---|
| slice-1.md | [one-line goal] | [ ] | [ ] |
```

`Done` = all tasks complete and tests pass. `Reviewed` = human has read the code and approved it for commit. Only move to the next slice once the current one is Reviewed.
19. Tell the human the plan is ready. Remind them: **read the code, not just the plan**.
