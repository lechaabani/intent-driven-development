# Intent-Driven Development (IDD)

A methodology that transforms any LLM into a Senior Software Engineer through optimized prompting and workflow management.

## Key Benefits

- **Token efficient**: ~400-800 tokens per request
- **Production-ready code**: First attempt success
- **Cost effective**: $24-150/month for a 5-dev team
- **Fast**: 20-30 minutes from idea to working code
- **Quality**: 0-1 bugs per feature average

---

## Quick Start

### 1. Choose Your Setup

All tools use the same three files:
- `SYSTEM_PROMPT.md` — Core IDD behaviors
- `templates/.claude.md` — Project context template
- `templates/.claudeignore` — Files to never touch

#### Cursor

```bash
cp SYSTEM_PROMPT.md /your/project/.cursorrules
cp templates/.claude.md /your/project/.claude.md
cp templates/.claudeignore /your/project/.claudeignore
```

#### Windsurf

```bash
cp SYSTEM_PROMPT.md /your/project/.windsurfrules
cp templates/.claude.md /your/project/.claude.md
cp templates/.claudeignore /your/project/.claudeignore
```

#### Claude Code CLI

```bash
# Use helper script (combines SYSTEM_PROMPT + .claude.md)
./scripts/setup-claude-code.sh /your/project

# Or manually:
cat SYSTEM_PROMPT.md templates/.claude.md > /your/project/.claude.md
cp templates/.claudeignore /your/project/.claudeignore
```

#### Web Interface (claude.ai, ChatGPT, etc.)

1. Copy `SYSTEM_PROMPT.md` content into Settings → Custom Instructions
2. Copy `templates/.claude.md` to `/your/project/.claude.md`
3. Copy `templates/.claudeignore` to `/your/project/.claudeignore`

### 2. Customize for Your Project

Edit `.claude.md` to match your project:
- Update stack, architecture, patterns
- List forbidden files
- Add project-specific conventions
- Document gotchas and recent decisions

### 3. Start Using IDD

Add shortcuts to your prompts:

```
@surgical Fix login button bug
@fast Fix typo in README
@plan Add user authentication
@check Review security of auth module
```

---

## How It Works

### The 6 Core Behaviors

1. **Surface Assumptions** — Lists assumptions before coding
2. **Stop If Confused** — Asks questions instead of guessing
3. **Push Back on Bad Ideas** — Challenges problematic approaches
4. **Simplicity First** — Prefers obvious solutions over clever ones
5. **Surgical Scope** — Touches only necessary files
6. **Dead Code Cleanup** — Flags unreachable code for removal

### The Workflow

```
User Request
    ↓
Read .claude.md
    ↓
List ASSUMPTIONS → Wait for approval
    ↓
Create PLAN → Wait for approval
    ↓
Implement surgically
    ↓
Document: CHANGES + UNTOUCHED + RISKS
```

### Shortcuts

| Shortcut | When to Use | What It Skips |
|----------|-------------|---------------|
| `@surgical` | Bug fix, small feature | Verbose assumptions |
| `@fast` | Typo, formatting | Assumptions + Plan |
| `@plan` | Complex feature | Nothing (full workflow) |
| `@check` | Code review only | Implementation |

---

## Project Files

### .claude.md
Your project context (read once per session):
- Architecture & stack
- Coding conventions
- Critical rules & forbidden files
- Common patterns
- Known gotchas

**Token budget**: <1,500 tokens

### .claudeignore
Files the LLM must never touch:
- Authentication code
- Payment processing
- Database migrations
- Secrets & config

**Format**: Same as `.gitignore`

### System Prompt
Core IDD behaviors (repeated every request):
- 6 core behaviors
- Workflow steps
- Output format
- Anti-patterns

**Token budget**: <500 tokens

---

## Token Budget

| Component | Size | Loaded |
|-----------|------|--------|
| System prompt | 299 tokens | Every request |
| .claude.md | 244 tokens | Once per session |
| .claudeignore | 48 tokens | Once per session |
| **Total first request** | **591 tokens** | — |
| **Subsequent requests** | **~400 tokens** | — |

### Cost Estimate

```
100 requests/day/dev × 20 days × 800 avg tokens = 160K tokens/month/dev
160K × $0.003 per 1K tokens = $4.80/month/dev
5 developers = $24/month
```

---

## Examples

See [docs/EXAMPLES.md](./docs/EXAMPLES.md) for detailed walkthroughs:

1. **Bug Fix** — Email validation not working (~8 min, 450 tokens)
2. **Feature** — Add "Remember Me" to login (~35 min, 2,100 tokens)
3. **Refactor** — Extract duplicate logic with dead code detection
4. **Confusion Handling** — How IDD handles vague requests

---

## Best Practices

### Do
- Keep `.claude.md` under 1,500 tokens
- Use shortcuts for 70% of requests
- Let the LLM challenge bad ideas
- Prune old decisions monthly

### Don't
- Skip the `.claudeignore` file
- Override when LLM flags confusion
- Add verbose explanations
- Duplicate info between files

---

## Documentation

- [SHORTCUTS.md](./docs/SHORTCUTS.md) — Detailed shortcut guide
- [EXAMPLES.md](./docs/EXAMPLES.md) — Complete walkthroughs
- [COMPARISON.md](./docs/COMPARISON.md) — Compare with alternatives
- [MIGRATION.md](./guides/MIGRATION.md) — Migrate from other tools

---

## Validation Tools

**Token Counter:**
```bash
./scripts/token-counter.sh
```
Validates all files are within token budgets.

**Cost Calculator:**
```bash
./scripts/cost-calculator.sh [devs] [requests/day] [work_days]
```
Estimates monthly costs based on usage.

---

## Contributing

1. Keep all changes token-efficient
2. Test with multiple LLMs
3. Measure before/after token usage

---

## License

MIT

---

**Version**: 1.0
**Tested with**: Claude, GPT-4, Gemini Pro
