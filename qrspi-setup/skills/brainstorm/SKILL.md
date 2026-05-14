---
name: brainstorm
description: Explore 2-3 meaningfully different ideas, approaches, or answers with trade-offs and a recommendation. Use standalone or inside QRSPI Questions whenever the human needs options, architectural direction is unclear, a question has multiple plausible answers, or divergent thinking would improve alignment.
---

# Brainstorm Skill

**Invoked by:** the Questions phase whenever a question needs options or idea generation, and standalone whenever the human asks to explore possible directions.

**Purpose:** Surface 2-3 meaningfully different ideas or approaches with trade-offs and a recommendation, then get human buy-in on a direction before continuing the current workflow.

---

## When to invoke this

Invoke when any of these are true:
- The human is starting a new project or a major new module
- The human has described a problem but not a solution
- A QRSPI Questions phase question has several plausible answers and the human needs options
- Multiple valid architectural approaches exist and the choice has downstream consequences
- The human explicitly asks to explore options

Do NOT invoke for bugfixes, small features with an obvious implementation, or when the human has already made a clear architectural choice.

This skill may be invoked multiple times in a single Questions phase. Each invocation should answer the current decision only, then return control to the active workflow.

---

## Process

1. **Check context first.** If this is an existing project, look for `CLAUDE.md`, `docs/adr/`, `docs/adr/patterns.md`. Understand what's already built and what patterns are established. Don't propose approaches that conflict with settled decisions.

2. **Understand the problem, not the solution.** Before proposing anything, make sure you understand *what problem* the human is solving and *who it's for*. Ask one clarifying question if the problem is unclear — one only.

3. **Propose 2-3 approaches.** Each approach must be:
   - Meaningfully different (not just stylistic variations)
   - Described in 3-5 sentences
   - Paired with its key trade-off (what do you gain, what do you give up)
   - Realistic given the project constraints you found in step 1

   Lead with your recommended option and say why.

4. **Apply YAGNI ruthlessly.** Remove scope creep from every option. The best design solves the problem stated — not the problem the human might have in the future.

5. **Get a reaction.** Ask the human which direction resonates or if they want to explore a different angle. One question. Wait for their answer.

6. **Lock in a direction.** Once the human picks (or hybrid-picks) an approach, summarize the chosen direction in 2 sentences. If invoked from QRSPI Questions, hand control back to the current question. If invoked standalone, stop after the summary unless the human asks to continue.

---

## Constraints

- Do not propose more than 3 approaches. More than 3 creates decision fatigue.
- Do not go into implementation details — no file names, no library choices, no code. That comes later.
- Do not start or advance the Q-phase interview inside this skill. This skill ends when a direction is chosen.
- One question at a time. Never ask two things in one message.
