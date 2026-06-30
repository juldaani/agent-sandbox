# Agent sandbox devcontainer — extends Pi base image.
# General-purpose development environment: conda, Node.js 22.x, Pi coding agent,
# and the AivoCode CLI client (installed from source for any workspace).
FROM ghcr.io/slamengine/base-images/pi-cpu:latest

# Copy setup scripts and environment definition.
COPY environment.yml setup.sh /tmp/setup/

# Lightweight setup — conda env with general-purpose Python packages.
RUN bash /tmp/setup/setup.sh && rm -rf /tmp/setup

# Install AivoCode CLI client into an isolated venv.
# Cloned from the canonical repo — works regardless of what workspace is mounted.
# Uses micromamba run because the system python3 lacks python3-venv/ensurepip.
RUN git clone https://github.com/juldaani/AivoCode /tmp/aivocode && \
    micromamba run -n env-sandbox bash /tmp/aivocode/cli/install.sh --venv /opt/aivocode-cli && \
    rm -rf /tmp/aivocode
