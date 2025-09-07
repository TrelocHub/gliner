FROM python:3.11-slim
WORKDIR /app
RUN pip install --no-cache-dir --upgrade pip --root-user-action=ignore \
    && pip cache purge \
    && pip install --no-cache-dir --force-reinstall torch==2.1.0 --index-url https://download.pytorch.org/whl/cpu --root-user-action=ignore \
    && pip install --no-cache-dir --force-reinstall transformers==4.35.2 gliner==0.2.13 fastapi==0.104.1 uvicorn[standard]==0.24.0 --root-user-action=ignore
COPY app.py .
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--log-level", "debug"]
