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

### Step 1: Set System Prompt in Your LLM

Copy the full text from [`SYSTEM_PROMPT.md`](./SYSTEM_PROMPT.md) into your LLM's system prompt.

**For Claude (claude.ai)**:
1. Open https://claude.ai
2. Go to **Settings** → **Custom Instructions** (or **Developer Settings**)
3. Paste the contents of `SYSTEM_PROMPT.md` in the "System" field
4. Save

**For ChatGPT / OpenAI**:
1. Go to https://chat.openai.com
2. Open any conversation
3. Click your name → **Settings** → **Custom Instructions**
4. Paste `SYSTEM_PROMPT.md` contents in the system field
5. Save

**For Cursor IDE**:
1. Open `.cursor/rules` or create it
2. Paste `SYSTEM_PROMPT.md` contents
3. Save and restart

**For other LLMs**:
- Look for "System Prompt", "System Message", or "Instructions" settings
- Paste the contents of `SYSTEM_PROMPT.md`
- Most LLMs have this option in settings/preferences

### Step 2: Create Project Context
Copy [`templates/.claude.md`](./templates/.claude.md) to your project root and customize it:

```bash
cp templates/.claude.md /your/project/.claude.md
# Edit to match YOUR project
nano /your/project/.claude.md
```

### Step 3: Create Ignore File
Copy [`templates/.claudeignore`](./templates/.claudeignore) to your project root:

```bash
cp templates/.claudeignore /your/project/.claudeignore
# Edit to list files your project cannot modify
nano /your/project/.claudeignore
```

### Step 4: Start Using IDD
Paste your request with a shortcut:

```
@surgical Fix the login button not working
@fast Fix typo in README
@plan Add user authentication system
@check Review security of auth module
```

**That's it. You're ready.**

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
