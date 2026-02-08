#!/bin/bash

# Token Counter for IDD
# Validates that all files are within token budget

echo "=== IDD Token Budget Validation ==="
echo ""

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# Function to estimate tokens (words × 1.3)
estimate_tokens() {
    local file=$1
    local words=$(wc -w < "$file" 2>/dev/null || echo 0)
    echo $((words * 13 / 10))
}

# Validate System Prompt
echo "1. SYSTEM_PROMPT.md"
if [ -f "$PROJECT_DIR/SYSTEM_PROMPT.md" ]; then
    tokens=$(estimate_tokens "$PROJECT_DIR/SYSTEM_PROMPT.md")
    if [ $tokens -le 520 ]; then
        echo -e "   ${GREEN}PASS${NC}: $tokens tokens (max: 520)"
    else
        echo -e "   ${RED}FAIL${NC}: $tokens tokens (max: 520)"
    fi
else
    echo -e "   ${YELLOW}SKIP${NC}: File not found"
fi

echo ""

# Validate .claude.md template
echo "2. templates/.claude.md"
if [ -f "$PROJECT_DIR/templates/.claude.md" ]; then
    tokens=$(estimate_tokens "$PROJECT_DIR/templates/.claude.md")
    if [ $tokens -le 1560 ]; then
        echo -e "   ${GREEN}PASS${NC}: $tokens tokens (max: 1560)"
    else
        echo -e "   ${RED}FAIL${NC}: $tokens tokens (max: 1560)"
    fi
else
    echo -e "   ${YELLOW}SKIP${NC}: File not found"
fi

echo ""

# Validate .claudeignore template
echo "3. templates/.claudeignore"
if [ -f "$PROJECT_DIR/templates/.claudeignore" ]; then
    tokens=$(estimate_tokens "$PROJECT_DIR/templates/.claudeignore")
    if [ $tokens -le 260 ]; then
        echo -e "   ${GREEN}PASS${NC}: $tokens tokens (max: 260)"
    else
        echo -e "   ${RED}FAIL${NC}: $tokens tokens (max: 260)"
    fi
else
    echo -e "   ${YELLOW}SKIP${NC}: File not found"
fi

echo ""

# Calculate total first request
echo "4. Total First Request"
sys_tokens=$(estimate_tokens "$PROJECT_DIR/SYSTEM_PROMPT.md" 2>/dev/null || echo 0)
claude_tokens=$(estimate_tokens "$PROJECT_DIR/templates/.claude.md" 2>/dev/null || echo 0)
ignore_tokens=$(estimate_tokens "$PROJECT_DIR/templates/.claudeignore" 2>/dev/null || echo 0)
total=$((sys_tokens + claude_tokens + ignore_tokens))

if [ $total -le 2200 ]; then
    echo -e "   ${GREEN}PASS${NC}: $total tokens (max: 2200)"
else
    echo -e "   ${RED}FAIL${NC}: $total tokens (max: 2200)"
fi

echo ""
echo "=== Summary ==="
echo "System Prompt:  $sys_tokens tokens"
echo ".claude.md:     $claude_tokens tokens"
echo ".claudeignore:  $ignore_tokens tokens"
echo "────────────────────────"
echo "Total:          $total tokens"
echo ""

# Cost calculation
echo "=== Monthly Cost Estimate (5 devs) ==="
# 100 requests/day × 20 days × 800 tokens avg
monthly_tokens=$((100 * 20 * 800 * 5))
# Claude pricing: $0.003 per 1K input tokens
cost=$(echo "scale=2; $monthly_tokens * 0.003 / 1000" | bc)
echo "Estimated cost: \$$cost/month"
echo "(Based on 100 requests/day/dev, 800 tokens avg)"
