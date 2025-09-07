FROM pytorch/pytorch:2.3.0   # <-- atenție, fără -cpu

WORKDIR /app

RUN pip install --no-cache-dir transformers gliner fastapi uvicorn[standard]

COPY app.py .

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
