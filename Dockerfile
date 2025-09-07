FROM pytorch/pytorch:2.3.1-cpu

WORKDIR /app

# Install Python dependencies
RUN pip install --no-cache-dir transformers gliner fastapi uvicorn[standard]

# Copy the FastAPI app
COPY app.py .

# Start service
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
