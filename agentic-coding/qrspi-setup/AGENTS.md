# Project Context

<!-- Replace this section with a brief description of this project: what it is, its main tech stack, and any critical constraints. Keep it under 5 lines. -->

---

# QRSPI Workflow

This project uses the QRSPI agentic workflow for all non-trivial work. Each phase is a slash command with its own context window. Do not carry context between phases.

## Phase Commands
| Phase | Command | Input | Output |
|---|---|---|---|
| Questions | `/qrspi-q` | Human's idea (in conversation) | `alignment.md` |
| Research | `/qrspi-r` | `alignment.md` | `research.md` |
| Design | `/qrspi-d` | `alignment.md` + `research.md` + `docs/adr/*.md` | `design.md` + ADR files |
| Structure Outline | `/qrspi-s` | `design.md` | `structure-outline.md` |
| Plan | `/qrspi-p` | `structure-outline.md` + `design.md` + `docs/adr/patterns.md` | `plan/slice-N.md` |
| Implementation | `/qrspi-i` | `plan/slice-N.md` + `design.md` + `docs/adr/` | Updated slice + `index.md` |
| Adversarial Review | `/qrspi-ar` | `git diff` + `plan/slice-N.md` + `design.md` + `docs/adr/` | Review report (in conversation) |

All session files live in: `docs/sessions/{NNN-short-description}/`

## Skills
| Skill | Location | Used In |
|---|---|---|
| Brainstorm | `brainstorm` | Standalone or Questions phase whenever options are needed |
| context7-cli | `context7-cli` | Research phase |
| TDD | `tdd` | Plan phase + implementation |

## Key Standards
- Vertical slices only. Every slice must be end-to-end testable.
- TDD: unit tests are always written test-first. No exceptions.
- Trunk-based development. Short-lived branches, frequent merges.
- User stories: *As a [role], I want [capability] so that [benefit].* Be extensive — cover all behaviors including edge cases.
- ADRs: written automatically by the Design phase agent when a decision qualifies. Format in `docs/adr/ADR-FORMAT.md`.
- Patterns: coding conventions live in `docs/adr/patterns.md`. All agents read this before planning or implementing.

## Instruction Budget Reminder
Each agent phase must stay under 40 instructions (this file + command + tools combined). Do not pad instructions. Fewer is better.
