# Use relative paths instead of parent directory references
FROM python:3.11-slim-bullseye

WORKDIR /app
# Copy requirements.txt first for better caching
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY app .

EXPOSE 80
CMD ["python", "app.py"]