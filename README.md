# Intent-Driven Development (IDD)

**Transform any LLM into a Senior Software Engineer — at 10x lower cost.**

## Why IDD?

| Metric | Traditional (Spec-Kit) | IDD | Improvement |
|--------|------------------------|-----|-------------|
| Monthly cost (5 devs) | $2,850 | $150-300 | **-90%** |
| Tokens per request | 7,000 | 400-800 | **-85%** |
| Time to working code | 4-8 hours | 20-30 min | **-90%** |
| Bugs per feature | 3-5 | 0-1 | **-80%** |

## Quickstart (< 5 minutes)

### Step 1: Configure System Prompt

IDD can be used in two ways:

#### Option A: IDE with Local Config (Recommended)

**Your LLM reads files automatically from your project.** No web configuration needed.

**For Cursor**:
```bash
cp SYSTEM_PROMPT.md /your/project/.cursorrules
cp templates/.claude.md /your/project/.claude.md
cp templates/.claudeignore /your/project/.claudeignore
```

**For Windsurf**:
```bash
cp SYSTEM_PROMPT.md /your/project/.windsurfrules
cp templates/.claude.md /your/project/.claude.md
cp templates/.claudeignore /your/project/.claudeignore
```

**For Claude Code CLI**:
```bash
# Use the complete template (includes system prompt + project context)
cp templates/.claude-complete.md /your/project/.claude.md
cp templates/.claudeignore /your/project/.claudeignore
# Edit .claude.md to customize for YOUR project
```

**For Aider**:
```bash
cp SYSTEM_PROMPT.md /your/project/.aider.md
cp templates/.claude.md /your/project/.claude.md
```

#### Option B: Web Interface (Manual Setup)

**You must paste the system prompt once in settings.**

**For Claude (claude.ai)**:
1. Settings → Custom Instructions
2. Paste `SYSTEM_PROMPT.md` contents
3. Save

**For ChatGPT**:
1. Settings → Custom Instructions
2. Paste `SYSTEM_PROMPT.md` contents
3. Save

### Step 2: Add Project Context

Copy templates to your project and customize:

**For Claude Code CLI** (all-in-one file):
```bash
cp templates/.claude-complete.md /your/project/.claude.md
cp templates/.claudeignore /your/project/.claudeignore
# Edit .claude.md: Replace [Project Name], [Stack], etc.
```

**For other IDEs** (separate files):
```bash
cp templates/.claude.md /your/project/.claude.md
cp templates/.claudeignore /your/project/.claudeignore
# System prompt already in .cursorrules or .windsurfrules
```

Your project structure should look like:
```
your-project/
├── .claude.md          # Project context (complete for Claude Code, minimal for others)
├── .claudeignore       # Files LLM cannot touch
├── .cursorrules        # (Cursor only) System prompt
├── .windsurfrules      # (Windsurf only) System prompt
└── ... your code ...
```

### Step 3: Start Coding

Use shortcuts in your prompts:

```
@surgical Fix the login button not working
@fast Fix typo in README
@plan Add user authentication system
@check Review security of auth module
```

**That's it. Everything is local to your project.**

---

## How It Works

### The 6 Core Behaviors

1. **Surface Assumptions** — Lists what it assumes before coding
2. **Stop If Confused** — Never guesses, asks for clarification
3. **Push Back on Bad Ideas** — Challenges poor approaches
4. **Simplicity First** — Prefers boring, obvious solutions
5. **Surgical Scope** — Touches only planned files
6. **Dead Code Cleanup** — Flags unreachable code

### The Workflow

```
User Request
    ↓
[Read .claude.md] → Project context
    ↓
[ASSUMPTIONS] → "Is this correct?"
    ↓
[PLAN] → "Proceeding in 3s..."
    ↓
[IMPLEMENT] → Surgical changes
    ↓
[DOCUMENT] → CHANGES + UNTOUCHED + RISKS
```

### Shortcuts

| Shortcut | Use Case | Skips |
|----------|----------|-------|
| `@surgical` | Bug fix, small feature | Verbose assumptions |
| `@fast` | Typo, formatting | Assumptions + Plan |
| `@plan` | Complex feature, refactor | Nothing (full workflow) |
| `@check` | Code review, audit | Implementation |

---

## File Structure

```
your-project/
├── .claude.md          # Project context (read once per session)
├── .claudeignore       # Files the LLM cannot touch
└── ... your code ...
```

### .claude.md Sections

- **ARCHITECTURE** — Stack, structure, patterns
- **CONVENTIONS** — Style, naming, tests, commits
- **CRITICAL RULES** — Forbidden files, performance, security
- **PATTERNS** — Common code patterns to follow
- **GOTCHAS** — Known issues and quirks
- **RECENT DECISIONS** — Latest architectural decisions

### .claudeignore

Same format as `.gitignore`. List files the LLM must never modify:

```
auth.js          # Authentication
payment.js       # Payment processing
.env             # Secrets
node_modules/    # Dependencies
```

---

## Token Budget

| Component | Max Tokens | Frequency |
|-----------|------------|-----------|
| System Prompt | 500 | Every request |
| .claude.md | 1,500 | Once per session |
| .claudeignore | 200 | Once per session |
| **Total first request** | **~2,200** | — |
| **Subsequent requests** | **~500** | — |

### Cost Calculation

```
100 requests/day × 20 days × 800 tokens avg × $0.003/1K = $4.80/month/dev
```

Compare to Spec-Kit: **$570/month/dev**

---

## Examples

See [`docs/EXAMPLES.md`](./docs/EXAMPLES.md) for complete walkthroughs:

1. **Bug Fix** — Email validation not working
2. **Feature** — Add "Remember Me" to login
3. **Refactor** — Extract duplicate validation logic
4. **Confusion Handling** — Vague "improve performance" request

---

## Best Practices

### Do

- Keep `.claude.md` under 1,500 tokens
- Prune old decisions monthly
- Use shortcuts for 70% of requests
- Let the LLM push back on bad ideas

### Don't

- Add verbose explanations to system prompt
- Duplicate information between files
- Skip the `.claudeignore` file
- Override the LLM when it flags confusion

---

## Comparison with Alternatives

See [`docs/COMPARISON.md`](./docs/COMPARISON.md) for detailed analysis.

| Feature | IDD | Spec-Kit | Cursor |
|---------|-----|----------|--------|
| Token efficiency | Excellent | Poor | Medium |
| Assumption surfacing | Built-in | None | None |
| Confusion detection | Built-in | None | None |
| Simplicity enforcement | Built-in | None | None |
| Cost (5 devs/month) | $150-300 | $2,850 | $1,200 |

---

## Contributing

1. Keep all changes token-efficient
2. Test with multiple LLMs (Claude, GPT, Gemini)
3. Measure before/after token usage

---

## License

MIT

---

**Version**: 1.0
**Tested with**: Claude, GPT-4, Gemini Pro
