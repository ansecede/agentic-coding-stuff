---
name: qrspi-r
description: Run the QRSPI Research phase to gather objective facts from alignment.md without making design or implementation decisions. Use after the Questions phase to produce docs/sessions/{session-id}/research.md.
---

# QRSPI — Research Phase

**Purpose:** Gather objective facts. No opinions, no implementation decisions.

---

## Session Check

The session identifier is: **$ARGUMENTS**

1. If no session ID was provided, ask: *"What's the session ID?"* Stop and wait.
2. Set `SESSION_DIR=docs/sessions/$ARGUMENTS`.
3. If `SESSION_DIR` does not exist, say: *"Session `$ARGUMENTS` not found. You may need to run `/qrspi-q` first."* Stop.
4. If `alignment.md` does not exist in `SESSION_DIR`, say: *"No `alignment.md` found. Run the Questions phase first (`/qrspi-q $ARGUMENTS`)."* Stop.
5. If `research.md` already exists, warn the human and ask whether to overwrite or continue.

---

## Context Load

6. Read `$SESSION_DIR/alignment.md`.
7. Extract only the **Needs Research** and **Open Unknowns** sections. These are your research targets. Do not re-read the full idea description — your job is to find facts, not validate the plan.

---

## Research Protocol

8. **Codebase:** Use Claude Code's built-in `Explore` sub-agent to trace relevant logic flows, identify existing endpoints, patterns, and interfaces. If Explore cannot locate what's needed, ask the human for directions before continuing.
9. **External docs:** Use the `context7-cli` skill for library/framework documentation. Fall back to web search only when context7 has no results.
10. **Web:** Use web search for anything context7 cannot cover: recent changes, issues, community patterns.
11. For every research target from step 7, produce: a factual finding, its source, and its confidence level (confirmed / likely / uncertain).
12. Do not form implementation opinions. Write what the code *does*, not what it *should do*.
13. If a research target cannot be answered, mark it explicitly as **unresolved** — it becomes a question for the Design phase.

---

## Iteration Reminder

14. Finishing initial research does **not** mean moving to Design. The human may want to dig deeper, challenge findings, or add new research targets. Stay until explicitly told to proceed.

---

## Output

15. Write `$SESSION_DIR/research.md` using this structure:

```markdown
# Research — [short description]

**Session:** [NNN-short-description]
**Date:** [today]

## Findings

### [Research Target 1]
- **Finding:** ...
- **Source:** ...
- **Confidence:** confirmed / likely / uncertain

### [Research Target N]
...

## Codebase Map
[Relevant files, functions, endpoints, data models found during exploration]

## External Dependencies
[Libraries, APIs, services — version, maturity, key constraints]

## Unresolved Items
[Items that could not be answered — carry forward to Design phase]
```

16. Tell the human the file has been written and the next step is `/qrspi-d $ARGUMENTS`.
