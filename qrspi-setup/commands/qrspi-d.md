---
name: qrspi-d
description: Run the QRSPI Design phase to turn alignment and research into a concrete solution direction, design.md, and qualifying ADRs. Use after Questions and Research are complete for a session.
---

# QRSPI — Design Phase

**Purpose:** Define where we are going and what the solution looks like. This is the brain surgery phase — align before a single line of code is planned.

---

## Session Check

1. If no session ID was provided ($ARGUMENTS is empty), ask: *"What's the session ID?"* Stop and wait.
2. Set `SESSION_DIR=docs/sessions/$ARGUMENTS`.
3. If `alignment.md` or `research.md` are missing from `SESSION_DIR`, tell the human which phase is missing and stop.
4. If `design.md` already exists, warn and ask whether to overwrite or continue.

---

## Context Load

5. Read `$SESSION_DIR/alignment.md` and `$SESSION_DIR/research.md`.
6. If `docs/adr/` exists, read all `*.md` files in it (except `ADR-FORMAT.md` and `patterns.md`). These are established architectural decisions that must be respected unless explicitly challenged. Also read `docs/adr/patterns.md` if it exists.

---

## Design Protocol

7. Brain-dump everything: synthesize your understanding of the current state, what we want to build, what the research revealed, and how they connect. **Don't hold anything back — get it all on the table.** The more you surface now, the less surprises later.
8. Propose the desired end state: architecture, key components, data flows, integration points.
9. Identify patterns from the codebase (or ADRs) that apply here. Flag any conflicts — old patterns the team has moved away from vs. newer standards.
10. List design decisions that are now resolved (from alignment + research).
11. List design decisions that are still open. Ask these to the human **one at a time**, providing your recommended answer for each. Wait for a response before asking the next.
12. Iterate. The human may redirect your proposed patterns, challenge decisions, or introduce new constraints. Update your understanding and re-discuss as needed.
13. Address any **Unresolved Items** from `research.md` during this discussion.

---

## Writing ADRs

14. As each significant decision crystallizes during the conversation, evaluate it against the three criteria in `docs/adr/ADR-FORMAT.md`:
    - Hard to reverse
    - Surprising without context
    - The result of a real trade-off

    If all three apply, **write the ADR immediately** — don't batch them to the end. Scan `docs/adr/` for the highest existing number and increment. Write `docs/adr/NNNN-slug.md` following the format in `ADR-FORMAT.md`. Tell the human: *"Writing ADR-NNNN for [decision]."* Then continue the discussion.

---

## Iteration Reminder

15. Finishing the brain-dump does **not** mean moving to Structure Outline. Stay in Design until the human explicitly says alignment is complete.

---

## Output

16. Write `$SESSION_DIR/design.md`. **Size scales with scope**: a bugfix may be 30 lines; a new module may be 200+. Be concise — no padding, no repetition.

```markdown
# Design — [short description]

**Session:** [NNN-short-description]
**Date:** [today]

## Current State
[What exists today that is relevant — architecture, key files, pain points]

## Desired End State
[What we are building and why — goals, user-facing behavior, system behavior]

## Architecture & Components
[Key components, their responsibilities, how they interact]

## Data Model Changes
[New or modified entities, fields, relationships — if applicable]

## Patterns to Follow
[Specific patterns from the codebase or ADRs this solution must conform to]

## Resolved Design Decisions
| Decision | Choice | Rationale |
|---|---|---|
| ... | ... | ... |

## Open Questions Going Forward
[Anything still unresolved — feed into Structure Outline or Plan]

## ADRs Written This Session
[List of ADR files written during this phase, e.g. 0003-event-sourced-orders.md]
```

17. Tell the human the next step is `/qrspi-s $ARGUMENTS`.
