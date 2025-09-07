FROM pytorch/pytorch:2.4.0-cpu-py3.11

WORKDIR /app

# Install Python dependencies
RUN pip install --no-cache-dir transformers gliner fastapi uvicorn[standard]

# Copy the FastAPI app
COPY app.py .

# Start service
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
