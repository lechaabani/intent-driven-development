# IDD Templates

This folder contains templates for setting up IDD in your project.

## Templates

All tools use the same three files:

### 1. SYSTEM_PROMPT.md (parent folder)
**What**: Core IDD behaviors (299 tokens)
**Use for**: All tools
**How**:
- Cursor → Copy to `.cursorrules`
- Windsurf → Copy to `.windsurfrules`
- Claude Code → Combine with `.claude.md`
- Web → Paste in Settings

### 2. .claude.md
**What**: Project-specific context (244 tokens)
**Use for**: All tools
**Location**: Always at project root as `.claude.md`

### 3. .claudeignore
**What**: Files the LLM cannot modify (48 tokens)
**Use for**: All tools
**Format**: Same as `.gitignore`

## How Each Tool Uses These Files

| Tool | System Prompt | Project Context | Ignore File |
|------|---------------|-----------------|-------------|
| **Cursor** | `SYSTEM_PROMPT.md` → `.cursorrules` | `.claude.md` | `.claudeignore` |
| **Windsurf** | `SYSTEM_PROMPT.md` → `.windsurfrules` | `.claude.md` | `.claudeignore` |
| **Claude Code CLI** | Combined into `.claude.md` | `.claude.md` | `.claudeignore` |
| **Web (claude.ai, ChatGPT)** | `SYSTEM_PROMPT.md` → Settings | `.claude.md` | `.claudeignore` |

## Setup Examples

### For Cursor
```bash
cp /path/to/idd/SYSTEM_PROMPT.md .cursorrules
cp /path/to/idd/templates/.claude.md .claude.md
cp /path/to/idd/templates/.claudeignore .claudeignore
# Edit .claude.md to match your project
```

### For Claude Code CLI
```bash
# Use helper script
/path/to/idd/scripts/setup-claude-code.sh .

# Or manually combine files
cat /path/to/idd/SYSTEM_PROMPT.md /path/to/idd/templates/.claude.md > .claude.md
cp /path/to/idd/templates/.claudeignore .claudeignore
# Edit .claude.md to match your project
```

## Token Budgets

| File | Tokens | When Loaded |
|------|--------|-------------|
| `SYSTEM_PROMPT.md` | 299 | Every request (or once if combined) |
| `.claude.md` | 244 | Once per session |
| `.claudeignore` | 48 | Once per session |

**Total first request**: 299 + 244 + 48 = **591 tokens**

All tools use the same files, just loaded differently based on the tool's capabilities.
