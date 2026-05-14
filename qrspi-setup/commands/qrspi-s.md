---
name: qrspi-s
description: Run the QRSPI Structure Outline phase to map high-level vertical slices from design.md without code or implementation details. Use after the Design phase to produce structure-outline.md.
---

# QRSPI — Structure Outline Phase

**Purpose:** Map how we get to the desired end state. High-level only — no implementation details, no code.

---

## Session Check

1. If no session ID was provided ($ARGUMENTS is empty), ask: *"What's the session ID?"* Stop and wait.
2. Set `SESSION_DIR=docs/sessions/$ARGUMENTS`.
3. If `design.md` is missing from `SESSION_DIR`, tell the human and stop.
4. If `structure-outline.md` already exists, warn and ask whether to overwrite.

---

## Context Load

5. Read `$SESSION_DIR/design.md`. This is your only input — do not re-read alignment or research files.

---

## Outline Protocol

6. Break the desired end state into **phases**. Each phase is a vertical slice: it must be end-to-end testable on its own. Never propose horizontal layers (e.g. "all database first, then all API").
7. For each phase, define:
   - What it delivers (user-visible or system-observable outcome)
   - What mocks or stubs are needed for dependencies not yet built
   - How it can be validated (manual test, automated test, demo)
   - Rough complexity (S / M / L)
8. Order phases by dependency and risk: tackle the most uncertain or foundational slice first.
9. Address testing strategy: is this primarily unit-testable, integration-testable, or E2E? Unit tests are always written test-first — no exceptions. For integration and E2E tests, note the approach (alongside or after) and why. Flag anything that is genuinely hard to unit-test and propose a mitigation (e.g. extract a pure function, use an adapter interface).
10. Flag any phases that require human checkpoint/review before proceeding.
11. Note any cross-cutting concerns (auth, logging, error handling) and in which phase they are introduced.

---

## Iteration Reminder

12. Finishing the outline does **not** mean moving to Plan. The human may want to reorder, split, or merge phases. Stay until explicitly told to proceed.

---

## Output

13. Write `$SESSION_DIR/structure-outline.md`. **Size scales with scope**: a small feature may be 1 phase; a new application may be 8+. Be concise.

```markdown
# Structure Outline — [short description]

**Session:** [NNN-short-description]
**Date:** [today]

## Phase Overview
| # | Phase Name | Delivers | Complexity | Checkpoint? |
|---|---|---|---|---|
| 1 | ... | ... | S/M/L | Yes/No |

## Phase Details

### Phase 1 — [Name]
**Delivers:** ...
**Mocks/Stubs needed:** ...
**Validation:** ...
**Testing approach:** ...
**Notes:** ...

### Phase N — [Name]
...

## Cross-Cutting Concerns
| Concern | Introduced In Phase | Notes |
|---|---|---|
| Auth | ... | ... |

## Testing Strategy
[Overall approach: TDD where applicable, what's hard to test and mitigations]

## Open Questions
[Anything that couldn't be resolved from the design — carry into Plan]
```

14. Tell the human the next step is `/qrspi-p $ARGUMENTS [phase-number]` to plan a specific phase slice.
