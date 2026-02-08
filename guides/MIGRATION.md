# Migration Guide: From Spec-Kit to IDD

Migrate from GitHub Spec-Kit to Intent-Driven Development in 30 minutes.

---

## Overview

| Before (Spec-Kit) | After (IDD) |
|-------------------|-------------|
| ~7000 token system prompt | ~300 token system prompt |
| Verbose specifications | Surgical assumptions |
| Waterfall workflow | Iterative workflow |
| $2,850/month (5 devs) | $24-150/month (5 devs) |

---

## Step 1: Replace System Prompt (5 minutes)

### Before (Spec-Kit)
Your current system prompt is likely 5000-7000 tokens with sections like:
- Role definition (500 tokens)
- Specification format (1500 tokens)
- Planning instructions (1000 tokens)
- Implementation guidelines (1500 tokens)
- Documentation requirements (1000 tokens)
- Examples (500 tokens)

### After (IDD)
Replace entirely with `SYSTEM_PROMPT.md` (~300 tokens):

```markdown
# SENIOR ENGINEER PROTOCOL

You are a senior software engineer. Goal: production-ready code, first attempt.

## CORE BEHAVIORS (Always Active)
1. SURFACE ASSUMPTIONS - List before coding
2. STOP IF CONFUSED - Never guess
3. PUSH BACK ON BAD IDEAS - State problem, propose alternative
4. SIMPLICITY FIRST - Prefer boring solutions
5. SURGICAL SCOPE - Touch only planned files
6. DEAD CODE CLEANUP - Flag unreachable code

[See full SYSTEM_PROMPT.md]
```

**Token savings**: 6,700 tokens per request

---

## Step 2: Convert Context Files (15 minutes)

### Mapping Spec-Kit → IDD

| Spec-Kit File | IDD Equivalent |
|---------------|----------------|
| `spec-kit.config.yaml` | `.claude.md` |
| `ARCHITECTURE.md` | `.claude.md` (ARCHITECTURE section) |
| `CONVENTIONS.md` | `.claude.md` (CONVENTIONS section) |
| `RULES.md` | `.claude.md` (CRITICAL RULES section) |
| Multiple config files | Single `.claude.md` |

### Example Conversion

**Before (Spec-Kit - Multiple files, ~3000 tokens total)**:

```yaml
# spec-kit.config.yaml (800 tokens)
project:
  name: MyApp
  type: web-application
  stack:
    frontend: React 18
    backend: Node.js
    database: PostgreSQL
  architecture:
    pattern: monorepo
    # ... 50 more lines
```

```markdown
# ARCHITECTURE.md (1200 tokens)
## Overview
This project follows a layered architecture...
[Long description with diagrams]

## Components
### Frontend
- React 18 with TypeScript
- Redux for state management
[More details...]
```

```markdown
# RULES.md (1000 tokens)
## Code Style
- Use ESLint with Airbnb config
- Prettier for formatting
[Many more rules...]

## Security
- Never store passwords in plain text
[More security rules...]
```

**After (IDD - Single file, ~250 tokens)**:

```markdown
# PROJECT: MyApp

## ARCHITECTURE
- Stack: React 18, Node.js, PostgreSQL
- Structure: src/components/, api/routes/
- Patterns: REST API, Redux state

## CONVENTIONS
- Style: ESLint Airbnb + Prettier
- Naming: camelCase (JS), snake_case (DB)
- Tests: Jest, 80% coverage
- Commits: Conventional Commits

## CRITICAL RULES
### Off-Limits Files
- auth.js, payment.js, .env

### Performance
- UI: <200ms, API: <500ms

### Security
- No plain-text passwords
- Parameterized queries only

## PATTERNS
[Code snippets for common patterns]

## GOTCHAS
[Known issues]
```

**Token savings**: 2,750 tokens

---

## Step 3: Create .claudeignore (5 minutes)

### Mapping Existing Rules

If you have rules in Spec-Kit config like:
```yaml
protected_files:
  - auth/*
  - payment/*
  - database/migrations/*
```

Convert to `.claudeignore`:
```
# Critical files
auth.js
payment.js
database/migrations/
.env

# Generated
node_modules/
dist/
build/
```

---

## Step 4: Adopt Shortcuts (Immediate)

### Replace Spec-Kit Modes

| Spec-Kit Mode | IDD Shortcut |
|---------------|--------------|
| `--quick` | `@fast` |
| `--detailed` | `@plan` |
| `--review` | `@check` |
| (no equivalent) | `@surgical` |

### Update Your Workflow

**Before**:
```
spec-kit generate --type=bugfix "Fix login button"
```

**After**:
```
@surgical Fix login button
```

---

## Step 5: Update Team Habits (1-2 days)

### Key Mindset Shifts

| Spec-Kit Habit | IDD Habit |
|----------------|-----------|
| Write detailed specs | Let AI surface assumptions |
| Review long plans | Approve short plans |
| Edit generated specs | Confirm or correct assumptions |
| Accept all AI output | Let AI push back on bad ideas |

### Team Training

1. **Day 1**: Share `README.md`, explain shortcuts
2. **Week 1**: Each dev tries 5-10 requests with IDD
3. **Week 2**: Collect feedback, adjust `.claude.md`
4. **Month 1**: Full adoption, retire Spec-Kit

---

## Verification Checklist

After migration, verify:

- [ ] System prompt is < 500 tokens
- [ ] `.claude.md` is < 1500 tokens
- [ ] `.claudeignore` covers critical files
- [ ] AI surfaces assumptions before coding
- [ ] AI stops when confused (test with vague request)
- [ ] AI pushes back on bad ideas (test with insecure request)
- [ ] Shortcuts work as expected

---

## Rollback Plan

If issues occur, you can run IDD and Spec-Kit in parallel:
1. Keep Spec-Kit config for complex features
2. Use IDD for bug fixes and small features
3. Gradually migrate as confidence grows

---

## Support

If you encounter issues during migration:
1. Check examples in `docs/EXAMPLES.md`
2. Verify token counts with `scripts/token-counter.sh`
3. Review shortcuts in `docs/SHORTCUTS.md`

---

## Expected Results After Migration

| Metric | Spec-Kit | IDD | Improvement |
|--------|----------|-----|-------------|
| Setup time | 30-60 min | < 5 min | 90% faster |
| Tokens/request | 7000 | 400-800 | 90% less |
| Monthly cost | $2,850 | $24-150 | 95% less |
| Time to code | 4-8 hours | 20-30 min | 90% faster |
| Bugs/feature | 3-5 | 0-1 | 80% fewer |
