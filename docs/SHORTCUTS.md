# IDD Shortcuts

Shortcuts optimize token usage by skipping unnecessary workflow steps.

## Available Shortcuts

### @surgical

**Use for**: Bug fixes, small isolated features

**Behavior**:
- Compact assumptions (2-3 max)
- Minimal plan
- Single file focus

**Token savings**: ~150 tokens

**Example**:
```
@surgical Fix button not clickable on mobile
```

**Output**:
```
ASSUMPTIONS:
1. Bug in CSS touch events
2. Fix in Button.jsx only

PLAN: Add touch-action CSS property

[Implementation]

CHANGES: Button.jsx (line 42): Added touch-action: manipulation
UNTOUCHED: App.jsx, index.css
```

---

### @fast

**Use for**: Trivial changes (typos, formatting, comments)

**Behavior**:
- Skip assumptions entirely
- Skip plan
- Direct implementation

**Token savings**: ~200 tokens

**Example**:
```
@fast Fix typo "recieve" → "receive" in utils.js
```

**Output**:
```
CHANGES: utils.js (line 15): Fixed typo "recieve" → "receive"
```

---

### @plan

**Use for**: Complex features, architectural changes, refactors

**Behavior**:
- Full assumptions (5+)
- Detailed plan with rationale
- Explicit scope boundaries
- Complete documentation

**Token savings**: None (full workflow)

**Example**:
```
@plan Add user authentication with JWT
```

**Output**:
```
ASSUMPTIONS:
1. JWT stored in httpOnly cookies
2. Refresh token mechanism needed
3. Backend already has user model
4. Using bcrypt for password hashing
5. Session duration: 1 day default

→ Wrong? Stop me now.

PLAN:
1. Create auth middleware — validate JWT on protected routes
2. Add login endpoint — verify password, issue tokens
3. Add logout endpoint — clear cookies
4. Add refresh endpoint — issue new access token
5. Update frontend — add auth context

SCOPE:
- To modify: authMiddleware.js, authController.js, AuthContext.jsx
- OFF-LIMITS: User.model.js, database.js, payment.js

→ Proceeding in 3 seconds unless redirected
```

---

### @check

**Use for**: Code review, security audit, performance analysis

**Behavior**:
- Read-only mode
- No modifications
- Analysis + recommendations

**Token savings**: Variable (no implementation tokens)

**Example**:
```
@check Review security of the auth module
```

**Output**:
```
SECURITY AUDIT: auth/

FINDINGS:
1. [HIGH] Password stored with MD5 (line 45)
   → Recommendation: Switch to bcrypt with cost factor 12

2. [MEDIUM] No rate limiting on login endpoint
   → Recommendation: Add express-rate-limit

3. [LOW] JWT secret in code (line 12)
   → Recommendation: Move to environment variable

SUMMARY:
- Critical issues: 1
- Medium issues: 1
- Low issues: 1

NO CHANGES MADE (audit only)
```

---

## When to Use Each Shortcut

| Scenario | Shortcut | Why |
|----------|----------|-----|
| "Fix this bug" | @surgical | Focused, minimal |
| "Fix typo" | @fast | No planning needed |
| "Add new feature" | @plan | Needs full workflow |
| "Review this code" | @check | No changes needed |
| "Refactor module" | @plan | Complex, needs planning |
| "Update comment" | @fast | Trivial change |
| "Fix CSS issue" | @surgical | Isolated fix |
| "Security audit" | @check | Analysis only |

---

## Token Savings Summary

| Request Type | Without Shortcut | With Shortcut | Savings |
|--------------|------------------|---------------|---------|
| Bug fix | ~600 tokens | ~450 tokens | 25% |
| Typo fix | ~400 tokens | ~200 tokens | 50% |
| Complex feature | ~800 tokens | ~800 tokens | 0% |
| Code review | ~500 tokens | ~400 tokens | 20% |

**Average savings across all requests**: ~105 tokens (15%)

---

## Combining with Context

Shortcuts work with your `.claude.md` context:

```
@surgical Fix the validation in signup form
```

The LLM will:
1. Read `.claude.md` for project context
2. Check `.claudeignore` for forbidden files
3. Apply @surgical behavior (compact workflow)
4. Respect project conventions

---

## Custom Shortcuts (Advanced)

You can define project-specific shortcuts in your `.claude.md`:

```markdown
## CUSTOM SHORTCUTS
- `@hotfix` → Production bug, skip tests, document for later
- `@migrate` → Database migration, extra caution, backup first
- `@perf` → Performance optimization, include benchmarks
```

The LLM will learn these and apply appropriate behavior.
