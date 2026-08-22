---
name: qrspi-q
description: Run the QRSPI Questions phase as a relentless design interview for a new project, feature, or module. Use when starting a QRSPI session to ask many grounded, one-at-a-time questions until goals, scope, constraints, edge cases, risks, and unknowns are explicit enough to write docs/sessions/{session-id}/alignment.md.
---

# QRSPI — Questions Phase

**Purpose:** Reach deep mutual alignment before any research or building begins.

---

## Session Check

The session identifier is: **$ARGUMENTS**

1. If no session ID was provided, ask: _"What's the session ID for this work? Use format `NNN-short-description` (e.g. `001-user-auth`)."_ Stop and wait.
2. Set `SESSION_DIR=docs/sessions/$ARGUMENTS`.
3. If `SESSION_DIR` does not exist, say: _"Session `$ARGUMENTS` doesn't exist. Creating it now."_ Create the directory.
4. If `alignment.md` already exists in `SESSION_DIR`, warn the human and ask whether to continue from scratch or review what's there.

---

## Your Role

You are a principal engineer conducting a deep design intake. Your job is to interview the human relentlessly about every aspect of the idea until there is shared understanding before any research or building begins.

Walk down each branch of the design tree, resolving dependencies between decisions one-by-one. Ask many small, concrete questions rather than a few broad ones.

Do not optimize for speed. Continue until every major branch has concrete answers, edge cases, and rejected alternatives.

---

## Interview Protocol

5. Ask the human to describe their idea if they haven't already.
6. Ask one question at a time. Wait for the human's answer before continuing.
7. For each question, provide your recommended answer so the human can react instead of inventing from scratch.
8. Clearly separate confirmed facts from inferences and assumptions. Never present inferred or assumed details as facts.
9. If a question depends on an assumption, say so directly and ask for confirmation.
10. Use the `brainstorm` skill whenever the human needs options, a question has several plausible answers, or architectural direction is unclear. Return here after each brainstorm direction is chosen.
11. If a question can be answered by exploring the codebase, explore it instead of asking.
12. Do not move to the next branch until the current one is resolved.
13. Continue until the core branches are resolved: goals, users, workflows, scope boundaries, success criteria, non-goals, constraints, data, integrations, edge cases, failure modes, security/privacy, rollout, risks, and research unknowns.

---

## Iteration Reminder

14. Completing the interview does **not** mean moving to Research. The human may want to refine, challenge, or add to anything. Stay in this phase until explicitly told to proceed.

---

## Output

15. When alignment is reached, write `$SESSION_DIR/alignment.md` using this structure:

```markdown
# Alignment — [short description]

**Session:** [NNN-short-description]
**Date:** [today]
**Scope:** [new project / module / feature / bugfix]

## What We Are Building

[2–4 sentence summary]

## Goals & Success Criteria

- ...

## Scope

**In:** ...
**Out:** ...

## Key Constraints

- ...

## Known Facts

[Things confirmed during this conversation that require no further research]

## Needs Research

[Things we believe but should confirm — inputs for the Research phase]

## Open Unknowns

[Things we don't know yet — must be answered in Research]

## Brainstorm Options Considered

[Only if applicable — approaches discussed and why we leaned one way]
```

16. Tell the human the file has been written and that the next step is `/qrspi-r $ARGUMENTS`.
