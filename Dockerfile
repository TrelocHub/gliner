FROM pytorch/pytorch:2.2.2-cpu

WORKDIR /app

RUN pip install --no-cache-dir transformers gliner fastapi uvicorn[standard]

COPY app.py .

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
