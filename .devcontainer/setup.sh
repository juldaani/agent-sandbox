#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# setup.sh — Lightweight environment setup for agent sandbox.
#
# What it does:
#   1. Creates the conda env from environment.yml (env-sandbox).
#   2. Enables micromamba shell init + auto-activates env-sandbox in bash.
#
# Assumptions:
#   - micromamba / mamba is available on PATH (pi-cpu base image provides it).
#   - The script and environment.yml live in the same directory when copied.
# ─────────────────────────────────────────────────────────────────────────────
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="${SCRIPT_DIR}/environment.yml"

echo "==== agent-sandbox setup ===="
echo ""

# ── 1. Conda environment ─────────────────────────────────────────────────────
echo "[1/2] Creating conda environment from ${ENV_FILE}"
mamba env create -f "${ENV_FILE}" -y
mamba clean -afy
echo ""

# ── 2. Shell auto-activate ───────────────────────────────────────────────────
echo "[2/2] Enabling micromamba shell init + auto-activate"
micromamba shell init -s bash --root-prefix /opt/conda
echo 'micromamba activate env-sandbox' >> /root/.bashrc

echo ""
echo "==== agent-sandbox setup complete ===="
