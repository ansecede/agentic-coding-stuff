# Sessions

Each session lives in its own subdirectory using the format `NNN-short-description`.

Example: `001-user-auth/`, `002-payment-integration/`, `003-search-refactor/`

Within each session:
```
NNN-short-description/
  alignment.md          ← Questions phase output
  research.md           ← Research phase output
  design.md             ← Design phase output
  structure-outline.md  ← Structure Outline phase output
  plan/
    index.md            ← Slice tracker
    slice-1.md          ← Plan for Phase 1
    slice-2.md          ← Plan for Phase 2
    ...
```

Sessions are **append-only** — never delete or overwrite a completed session. If you need to redo a phase, the command will ask before overwriting.
