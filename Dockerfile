FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

COPY . /app

RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir jupyterlab \
    && pip install --no-cache-dir .

EXPOSE 8888

CMD ["bash", "-lc", "python install-kernel.py && exec jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --ServerApp.token=${JUPYTER_TOKEN:-nemo} --ServerApp.allow_origin='*' --ServerApp.allow_remote_access=True"]
