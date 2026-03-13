#!/usr/bin/env bash
set -euo pipefail

PORT="${PORT:-11434}"

# Persist model cache to Railway Volume if mounted
# Recommended mount path: /ollama
export OLLAMA_HOST="0.0.0.0:${PORT}"
export OLLAMA_MODELS="${OLLAMA_MODELS:-/ollama/models}"

mkdir -p "${OLLAMA_MODELS}"

echo "Starting Ollama on ${OLLAMA_HOST}"
ollama serve &
SERVER_PID="$!"

sleep 1

if [[ "${PULL_MODEL_ON_START:-0}" == "1" ]]; then
  MODEL="${OLLAMA_MODEL_TO_PULL:-llama3.1:8b}"
  echo "Pulling model: ${MODEL}"
  ollama pull "${MODEL}" || true
fi

wait "${SERVER_PID}"

