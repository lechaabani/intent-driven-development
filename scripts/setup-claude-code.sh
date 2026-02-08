#!/bin/bash

# Setup script for Claude Code CLI
# Combines SYSTEM_PROMPT.md + .claude.md into single .claude.md

if [ -z "$1" ]; then
    echo "Usage: $0 /path/to/your/project"
    exit 1
fi

PROJECT_DIR="$1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IDD_DIR="$(dirname "$SCRIPT_DIR")"

echo "Setting up IDD for Claude Code CLI in: $PROJECT_DIR"
echo ""

# Check if files exist
if [ ! -f "$IDD_DIR/SYSTEM_PROMPT.md" ]; then
    echo "Error: SYSTEM_PROMPT.md not found"
    exit 1
fi

if [ ! -f "$IDD_DIR/templates/.claude.md" ]; then
    echo "Error: templates/.claude.md not found"
    exit 1
fi

# Create combined .claude.md
echo "Creating .claude.md (system prompt + project context)..."
cat "$IDD_DIR/SYSTEM_PROMPT.md" > "$PROJECT_DIR/.claude.md"
echo "" >> "$PROJECT_DIR/.claude.md"
echo "---" >> "$PROJECT_DIR/.claude.md"
echo "" >> "$PROJECT_DIR/.claude.md"
cat "$IDD_DIR/templates/.claude.md" >> "$PROJECT_DIR/.claude.md"

# Copy .claudeignore
echo "Copying .claudeignore..."
cp "$IDD_DIR/templates/.claudeignore" "$PROJECT_DIR/.claudeignore"

echo ""
echo "✓ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Edit $PROJECT_DIR/.claude.md"
echo "   - Update PROJECT name, stack, architecture"
echo "   - Customize conventions and rules"
echo "2. Edit $PROJECT_DIR/.claudeignore"
echo "   - Add files specific to your project"
echo "3. Start using: @surgical Fix bug X"
