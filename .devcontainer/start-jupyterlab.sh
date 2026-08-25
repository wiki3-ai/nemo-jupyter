#!/usr/bin/env bash
set -euo pipefail

VENV_DIR="${WORKSPACE_FOLDER:-/workspaces/nemo-jupyter}/.venv"
LOG_FILE="${WORKSPACE_FOLDER:-/workspaces/nemo-jupyter}/.jupyterlab.log"
PID_FILE="${WORKSPACE_FOLDER:-/workspaces/nemo-jupyter}/.jupyterlab.pid"

if [ -f "${PID_FILE}" ] && kill -0 "$(cat "${PID_FILE}")" >/dev/null 2>&1; then
  exit 0
fi

nohup "${VENV_DIR}/bin/jupyter" lab \
  --ip=0.0.0.0 \
  --port=8888 \
  --no-browser \
  --ServerApp.token="${JUPYTER_TOKEN:-nemo}" \
  --ServerApp.allow_origin='*' \
  >"${LOG_FILE}" 2>&1 &

echo $! > "${PID_FILE}"
