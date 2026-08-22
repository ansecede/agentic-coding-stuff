---
name: qrspi-ar
description: Run the QRSPI Adversarial Review phase to challenge a completed vertical slice by reviewing the git diff against a reference. Use after implementation to find blocking risks before marking a slice reviewed.
---

# QRSPI — Adversarial Review

**Purpose:** Break confidence in the change before it ships. Your job is not to validate — it is to find the strongest reasons this slice should not be marked Reviewed yet.

**Usage:** `/qrspi-ar [session-id] [phase-number] [optional: git-ref]`
Examples:
- `/qrspi-ar 001-user-auth 1` — diffs against HEAD (staged + unstaged)
- `/qrspi-ar 001-user-auth 1 main` — diffs current branch against main

**Fresh context is mandatory.** Do not run this inside an ongoing implementation session. Open a new context window. The objectivity of this review depends on it.

---

## Input Collection

1. Parse $ARGUMENTS as `[session-id] [phase-number] [git-ref?]`. If session or phase is missing, ask. If no git-ref is given, default to `HEAD`.
2. Run: `git diff [git-ref]` — this is the primary subject of review.
3. If the diff is empty, say: *"No changes found against [ref]. Nothing to review."* Stop.
4. Read `$SESSION_DIR/plan/slice-[PHASE].md` — for the stated task intent and acceptance criteria.
5. Read `$SESSION_DIR/design.md` — for architectural intent.
6. Read all `docs/adr/*.md` (excluding `ADR-FORMAT.md`) and `docs/adr/patterns.md` if they exist.

Do not read `alignment.md` or `research.md`. Keep context lean and unbiased by upstream decisions.

---

## Operating Stance

Default to skepticism. Assume the change can fail in subtle, high-cost, or hard-to-detect ways until the evidence says otherwise. Do not give credit for good intent, partial fixes, or likely follow-up work. If something only works on the happy path, that is a real weakness.

---

## Attack Surface — Priority Order

Check these in order. Weight findings by cost of failure:

1. **Acceptance criteria gaps** — For each task's acceptance criterion in the slice file: does the diff actually satisfy it, or does it merely appear to? A test that passes but doesn't assert the right thing is worse than no test.
2. **TDD evidence** — Are tests present in the diff? Are they testing behavior (external contracts) or implementation details (which break on refactor)? Tests that only verify the happy path are a finding.
3. **ADR and pattern violations** — Does any code in the diff contradict a decision in `docs/adr/`? Does it introduce a deprecated pattern from `patterns.md`?
4. **Vertical slice purity** — Did this slice introduce hidden horizontal coupling? (e.g., a data layer change that implicitly depends on a future API not yet built, or a UI change that hardcodes behavior that belongs in the backend)
5. **Trust and boundary failures** — auth, permissions, tenant isolation, unvalidated input crossing a trust boundary.
6. **Data integrity** — data loss, corruption, irreversible state changes, missing rollback safety, non-idempotent operations.
7. **Concurrency and ordering** — race conditions, stale state, re-entrancy, ordering assumptions that break under load.
8. **Failure path coverage** — null, empty state, timeout, degraded dependency, partial failure. If only the happy path is handled, that is a finding.
9. **Observability gaps** — would a failure in this code be visible? Is there enough logging/metrics to recover from an incident?
10. **Compatibility** — schema drift, API contract changes, version skew between components.

---

## Finding Bar

Report only material findings. Do not include style, naming, low-value cleanup, or speculation without evidence in the diff.

Every finding must answer:
1. What can go wrong?
2. Why is this code location vulnerable?
3. What is the likely impact?
4. What concrete change reduces the risk?

Prefer one strong finding over several weak ones. Do not dilute serious issues with filler. If the change looks solid, say so directly.

---

## Output

Write a review report directly in the conversation (no file output). Use this structure:

```
## Adversarial Review — Slice [N]: [Phase Name]
**Session:** [NNN-short-description]
**Diff base:** [git-ref]
**Verdict:** BLOCKING FINDINGS / ADVISORY ONLY / APPROVED

---

### Blocking Findings
*Must be resolved before this slice can be marked Reviewed.*

#### [B1] [Short title]
- **Location:** `path/to/file.ts` lines X–Y
- **What can go wrong:** ...
- **Why vulnerable:** ...
- **Impact:** ...
- **Fix:** ...
- **Confidence:** 0.0–1.0

---

### Advisory Findings
*Worth knowing. Human decides whether to act before or after merge.*

#### [A1] [Short title]
- **Location:** ...
- **What can go wrong:** ...
- **Fix:** ...
- **Confidence:** 0.0–1.0

---

### Summary
[2–3 sentences. Ship/no-ship assessment. Direct, not neutral.]
```

If there are zero findings of a tier, omit that section entirely.

---

## Verdict Rules

- **BLOCKING FINDINGS** — at least one material finding that could cause data loss, security failure, broken acceptance criteria, or production incident. Do not mark the slice Reviewed until resolved.
- **ADVISORY ONLY** — findings exist but none are blocking. Human decides.
- **APPROVED** — no material findings. Slice may be marked Reviewed.

After the report, tell the human: *"To mark this slice Reviewed, return to the implementation session and run `/qrspi-i [session-id] [phase]`."*
