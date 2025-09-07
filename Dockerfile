FROM cnstark/pytorch:2.4.0-py3.10.15-ubuntu22.04
WORKDIR /app

RUN pip install --no-cache-dir transformers gliner fastapi uvicorn[standard]

COPY app.py .

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
