---
name: qrspi-i
description: Run the QRSPI Implementation phase to execute one planned vertical slice test-first until it is ready for human review. Use with a session id and phase number after the Plan phase is complete.
---

# QRSPI — Implementation Phase

**Purpose:** Execute one vertical slice task by task, test-first, until the slice is done and human-reviewed. This is the fastest phase — the alignment work is already done.

**Usage:** `/qrspi-i [session-id] [phase-number]`
Example: `/qrspi-i 001-user-auth 1`

---

## Session & Phase Check

1. Parse $ARGUMENTS as `[session-id] [phase-number]`. If either is missing, ask: *"Please provide session ID and phase number (e.g. `001-user-auth 1`)."* Stop and wait.
2. Set `SESSION_DIR=docs/sessions/[session-id]` and `PHASE=[phase-number]`.
3. If `$SESSION_DIR/plan/slice-[PHASE].md` does not exist, say: *"No plan found for phase [PHASE]. Run `/qrspi-p [session-id] [PHASE]` first."* Stop.
4. If `$SESSION_DIR/plan/index.md` does not exist, say: *"No index.md found. Run the Plan phase first."* Stop.

---

## Context Load

5. Read `$SESSION_DIR/plan/slice-[PHASE].md`. This is your primary guide — the user stories, tasks, mocks, and **acceptance criteria** are what you are implementing toward. The acceptance criterion for each task is the definition of done for that task.
6. Read `$SESSION_DIR/design.md` for architecture context.
7. Read `docs/adr/patterns.md` if it exists. All code must follow established conventions.
8. Read any `docs/adr/*.md` files (excluding `ADR-FORMAT.md`). Conformance to ADRs is mandatory.

---

## Work Tree

9. Scan `slice-[PHASE].md` for the task list. Present the human with a summary of the tasks in order and ask: *"Ready to start at Task 1, or do you want to pick up from a specific task?"* This allows resuming mid-slice.

---

## Per-Task Implementation Loop

For each task, in order:

10. **State the task.** Announce which task you are starting and restate its acceptance criterion. This is the target — everything else is implementation detail.

11. **Write the test first.** For every unit-testable module, write the failing test before touching the implementation. No exceptions. Follow the `tdd` skill. Run the test to confirm it fails for the right reason.

12. **Implement.** Write the minimum code to make the test pass. No gold-plating. If the task requires a mock or stub for a dependency from a future phase, build the stub and note it clearly.

13. **Run tests.** All tests in the affected scope must pass. Do not proceed if anything is broken.

14. **Mark task done in slice file.** Update the `- [ ]` checkbox for the user story or task in `slice-[PHASE].md` to `- [x]`.

15. **Pause at checkpoints.** When the slice file has a `⚑ Checkpoint`, stop. Describe what was built and what the human should verify. Wait for explicit confirmation before continuing.

---

## Iteration

16. This is the most iterative phase. After any task, the human may: review code and request changes, ask questions, challenge an implementation choice, or spot a gap in the plan. Stay in this loop. Do not rush toward slice completion — correctness and human understanding come first. Horthy's principle: the agent writes code fast; the craft standard is that **no slop makes it into production**.

17. If a requested change contradicts an ADR, say so explicitly and ask how to proceed. Do not silently deviate from established decisions.

---

## Slice Completion

18. When all tasks in the slice are marked done and all tests pass, say: *"All tasks in Slice [PHASE] are complete. Before marking Reviewed, consider running `/qrspi-ar [session-id] [PHASE]` in a fresh context window for an adversarial review. When you're satisfied, tell me to mark it as reviewed."*

19. When the human confirms review: update `$SESSION_DIR/plan/index.md` — mark the `Reviewed` column for this slice as `[x]`.

20. Tell the human: *"Slice [PHASE] is done and reviewed — ready to commit/merge. The next slice is `/qrspi-i [session-id] [PHASE+1]`, or run `/qrspi-p` first if it hasn't been planned yet."*

---

## Iteration Reminder

21. Completing a slice does **not** mean the session is over. The human may want to revisit, refactor, or extend before moving on. Stay available until explicitly dismissed.
