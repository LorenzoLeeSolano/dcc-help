#!/usr/bin/env bash
set -euo pipefail

# Start Ollama server
ollama serve >/var/log/ollama.log 2>&1 &
OLLAMA_PID=$!

# Forward signals to the Ollama process
trap 'kill -TERM "$OLLAMA_PID" 2>/dev/null || true' TERM INT
trap 'kill -TERM "$OLLAMA_PID" 2>/dev/null || true' EXIT

echo "Waiting for Ollama to start..."
for _ in $(seq 1 100); do
    if curl -fsS http://127.0.0.1:11434/api/tags >/dev/null 2>&1; then
        break
    fi
  sleep 0.2
done

# Check Server Running
if ! curl -fsS http://127.0.0.1:11434/api/tags >/dev/null 2>&1; then
    echo "Ollama failed to start within the expected time."
    exit 1
fi

echo "Ollama is running on http://127.0.0.1:11434"
echo "Logs: /var/log/ollama.log"

# Pull Model
if [[ -n "${DCC_HELP_MODEL:-}" ]]; then
    echo "Pulling model: $DCC_HELP_MODEL"
    if ! ollama pull "$DCC_HELP_MODEL"; then
        echo "Model pull failed."
        exit 1
    fi
else
    echo "DCC_HELP_MODEL not set."
    exit 1
fi

cd /workspace || exit 1

# If we have an interactive TTY, open a shell.
# If not (e.g., docker compose up -d), keep the container alive.
if [ -t 0 ] && [ -z "${NO_SHELL:-}" ]; then
    echo "Interactive TTY detected. Starting shell..."
    exec "${SHELL:-/bin/bash}"
else
    echo "No interactive TTY detected. Keeping container running (waiting on Ollama)."
    wait "$OLLAMA_PID"
fi
