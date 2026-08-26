FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

COPY . /app

RUN pip install --no-cache-dir --upgrade pip \
    && apt-get update \
    && apt-get install -y --no-install-recommends build-essential curl git \
    && rm -rf /var/lib/apt/lists/* \
    && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --profile minimal \
    && . "$HOME/.cargo/env" \
    && pip install --no-cache-dir "nmo-python @ git+https://github.com/wiki3-ai/nemo.git@main#subdirectory=nemo-python" \
    && pip install --no-cache-dir jupyterlab \
    && pip install --no-cache-dir --no-deps . \
    && rm -rf "$HOME/.rustup" "$HOME/.cargo"

EXPOSE 8888

CMD ["bash", "-lc", "python install-kernel.py && exec jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --ServerApp.token=${JUPYTER_TOKEN:-nemo} --ServerApp.allow_origin='*' --ServerApp.allow_remote_access=True"]
