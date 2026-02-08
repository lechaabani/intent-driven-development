# IDD Templates

This folder contains templates for setting up IDD in your project.

## Templates

### 1. SYSTEM_PROMPT.md (parent folder)
**What**: Core IDD behaviors (300 tokens)
**Use for**: Cursor, Windsurf, Aider, Web interfaces
**Location**: Copy to `.cursorrules`, `.windsurfrules`, or paste in web settings

### 2. .claude.md
**What**: Project-specific context only (244 tokens)
**Use for**: Projects using Cursor, Windsurf, or web interfaces
**Why separate**: System prompt is already in `.cursorrules` or web settings

### 3. .claude-complete.md
**What**: System prompt + project context (543 tokens)
**Use for**: Claude Code CLI
**Why combined**: Claude Code reads only `.claude.md`, so we include everything

### 4. .claudeignore
**What**: Files the LLM cannot modify (48 tokens)
**Use for**: All tools
**Format**: Same as `.gitignore`

## Which Template to Use?

| Tool | System Prompt | Project Context | Ignore File |
|------|---------------|-----------------|-------------|
| **Cursor** | `SYSTEM_PROMPT.md` → `.cursorrules` | `.claude.md` | `.claudeignore` |
| **Windsurf** | `SYSTEM_PROMPT.md` → `.windsurfrules` | `.claude.md` | `.claudeignore` |
| **Claude Code CLI** | — | `.claude-complete.md` → `.claude.md` | `.claudeignore` |
| **Aider** | `SYSTEM_PROMPT.md` → `.aider.md` | `.claude.md` | — |
| **claude.ai** | `SYSTEM_PROMPT.md` → Settings | `.claude.md` | `.claudeignore` |
| **ChatGPT** | `SYSTEM_PROMPT.md` → Settings | `.claude.md` | `.claudeignore` |

## Setup Example

### For Cursor
```bash
cp /path/to/idd/SYSTEM_PROMPT.md .cursorrules
cp /path/to/idd/templates/.claude.md .claude.md
cp /path/to/idd/templates/.claudeignore .claudeignore
# Edit .claude.md to match your project
```

### For Claude Code CLI
```bash
cp /path/to/idd/templates/.claude-complete.md .claude.md
cp /path/to/idd/templates/.claudeignore .claudeignore
# Edit .claude.md to match your project
```

## Token Budgets

| File | Tokens | When Loaded |
|------|--------|-------------|
| `SYSTEM_PROMPT.md` | 299 | Every request |
| `.claude.md` | 244 | Once per session |
| `.claude-complete.md` | 543 | Once per session |
| `.claudeignore` | 48 | Once per session |

**Total first request**:
- Separate files: 299 + 244 + 48 = **591 tokens**
- Complete file: 543 + 48 = **591 tokens**

Same total, just organized differently!
