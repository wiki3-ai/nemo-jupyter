#!/usr/bin/env bash
set -euo pipefail

VENV_DIR="${WORKSPACE_FOLDER:-/workspaces/nemo-jupyter}/.venv"

python3 -m venv "${VENV_DIR}"
"${VENV_DIR}/bin/pip" install --upgrade pip
"${VENV_DIR}/bin/pip" install "nmo-python @ git+https://github.com/wiki3-ai/nemo.git@main#subdirectory=nemo-python"
"${VENV_DIR}/bin/pip" install -e .[dev]
"${VENV_DIR}/bin/python" install-kernel.py
