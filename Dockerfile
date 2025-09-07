FROM python:3.11-slim

WORKDIR /app

# Install dependencies
RUN pip install --no-cache-dir torch transformers gliner fastapi uvicorn[standard]

# Copy the FastAPI app
COPY app.py .

# Start service
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
