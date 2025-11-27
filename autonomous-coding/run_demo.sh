#!/bin/bash

# Autonomous Coding Agent - Quick Demo Runner
# This script demonstrates how to run the autonomous coding agent

echo "=================================="
echo "Autonomous Coding Agent Demo"
echo "=================================="
echo ""

# Check for API key
if [ -z "$ANTHROPIC_API_KEY" ]; then
    echo "❌ Error: ANTHROPIC_API_KEY not set"
    echo ""
    echo "Please set your API key first:"
    echo "  export ANTHROPIC_API_KEY='your-api-key-here'"
    echo ""
    echo "Get your API key from: https://console.anthropic.com/"
    exit 1
fi

echo "✅ API Key found"
echo "✅ Python $(python3 --version 2>&1 | cut -d' ' -f2)"
echo "✅ Claude SDK $(pip show claude-code-sdk 2>/dev/null | grep Version | cut -d' ' -f2)"
echo ""

# Default values
PROJECT_DIR="./test_project"
MAX_ITERATIONS=2
SPEC_FILE="app_spec_simple.txt"

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --project-dir)
            PROJECT_DIR="$2"
            shift 2
            ;;
        --max-iterations)
            MAX_ITERATIONS="$2"
            shift 2
            ;;
        --spec)
            SPEC_FILE="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

echo "Configuration:"
echo "  Project dir: $PROJECT_DIR"
echo "  Max iterations: $MAX_ITERATIONS"
echo "  Spec file: $SPEC_FILE"
echo ""

# Copy spec file to prompts directory if using custom one
if [ "$SPEC_FILE" != "app_spec.txt" ]; then
    if [ -f "prompts/$SPEC_FILE" ]; then
        cp "prompts/$SPEC_FILE" "prompts/app_spec.txt.temp"
        echo "Using custom spec: $SPEC_FILE"
    fi
fi

echo "Starting autonomous agent..."
echo "Press Ctrl+C to stop at any time"
echo ""
sleep 2

# Run the agent
python3 autonomous_agent_demo.py \
    --project-dir "$PROJECT_DIR" \
    --max-iterations "$MAX_ITERATIONS"

# Cleanup temp files
if [ -f "prompts/app_spec.txt.temp" ]; then
    rm "prompts/app_spec.txt.temp"
fi

echo ""
echo "=================================="
echo "Demo complete!"
echo "=================================="
