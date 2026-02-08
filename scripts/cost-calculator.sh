#!/bin/bash

# Cost Calculator for IDD
# Estimates monthly costs based on usage patterns

echo "=== IDD Cost Calculator ==="
echo ""

# Default values
DEVS=${1:-5}
REQUESTS_PER_DAY=${2:-100}
WORK_DAYS=${3:-20}
AVG_INPUT_TOKENS=${4:-800}
AVG_OUTPUT_TOKENS=${5:-500}

# Claude pricing (as of 2025)
CLAUDE_INPUT_PRICE=0.003   # per 1K tokens
CLAUDE_OUTPUT_PRICE=0.015  # per 1K tokens

# GPT-4 pricing (for comparison)
GPT4_INPUT_PRICE=0.01      # per 1K tokens
GPT4_OUTPUT_PRICE=0.03     # per 1K tokens

echo "Configuration:"
echo "  Developers:        $DEVS"
echo "  Requests/day/dev:  $REQUESTS_PER_DAY"
echo "  Work days/month:   $WORK_DAYS"
echo "  Avg input tokens:  $AVG_INPUT_TOKENS"
echo "  Avg output tokens: $AVG_OUTPUT_TOKENS"
echo ""

# Calculate monthly tokens
MONTHLY_REQUESTS=$((DEVS * REQUESTS_PER_DAY * WORK_DAYS))
MONTHLY_INPUT_TOKENS=$((MONTHLY_REQUESTS * AVG_INPUT_TOKENS))
MONTHLY_OUTPUT_TOKENS=$((MONTHLY_REQUESTS * AVG_OUTPUT_TOKENS))

echo "Monthly Volume:"
echo "  Total requests:    $MONTHLY_REQUESTS"
echo "  Input tokens:      $MONTHLY_INPUT_TOKENS"
echo "  Output tokens:     $MONTHLY_OUTPUT_TOKENS"
echo ""

# Calculate costs
CLAUDE_INPUT_COST=$(echo "scale=2; $MONTHLY_INPUT_TOKENS * $CLAUDE_INPUT_PRICE / 1000" | bc)
CLAUDE_OUTPUT_COST=$(echo "scale=2; $MONTHLY_OUTPUT_TOKENS * $CLAUDE_OUTPUT_PRICE / 1000" | bc)
CLAUDE_TOTAL=$(echo "scale=2; $CLAUDE_INPUT_COST + $CLAUDE_OUTPUT_COST" | bc)

GPT4_INPUT_COST=$(echo "scale=2; $MONTHLY_INPUT_TOKENS * $GPT4_INPUT_PRICE / 1000" | bc)
GPT4_OUTPUT_COST=$(echo "scale=2; $MONTHLY_OUTPUT_TOKENS * $GPT4_OUTPUT_PRICE / 1000" | bc)
GPT4_TOTAL=$(echo "scale=2; $GPT4_INPUT_COST + $GPT4_OUTPUT_COST" | bc)

# Spec-Kit comparison (7000 tokens avg input)
SPECKIT_INPUT=$((MONTHLY_REQUESTS * 7000))
SPECKIT_CLAUDE=$(echo "scale=2; $SPECKIT_INPUT * $CLAUDE_INPUT_PRICE / 1000 + $MONTHLY_OUTPUT_TOKENS * $CLAUDE_OUTPUT_PRICE / 1000" | bc)

echo "=== Monthly Cost Estimates ==="
echo ""
echo "IDD with Claude:"
echo "  Input:   \$$CLAUDE_INPUT_COST"
echo "  Output:  \$$CLAUDE_OUTPUT_COST"
echo "  Total:   \$$CLAUDE_TOTAL"
echo ""
echo "IDD with GPT-4:"
echo "  Input:   \$$GPT4_INPUT_COST"
echo "  Output:  \$$GPT4_OUTPUT_COST"
echo "  Total:   \$$GPT4_TOTAL"
echo ""
echo "Spec-Kit with Claude (comparison):"
echo "  Total:   \$$SPECKIT_CLAUDE"
echo ""

# Calculate savings
SAVINGS=$(echo "scale=0; ($SPECKIT_CLAUDE - $CLAUDE_TOTAL) * 100 / $SPECKIT_CLAUDE" | bc)
echo "=== Savings vs Spec-Kit ==="
echo "  You save: $SAVINGS%"
echo "  That's \$$(echo "scale=2; $SPECKIT_CLAUDE - $CLAUDE_TOTAL" | bc)/month"
echo ""

echo "Usage: $0 [devs] [requests/day] [work_days] [input_tokens] [output_tokens]"
echo "Example: $0 10 50 22 600 400"
