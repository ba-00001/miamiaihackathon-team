# Use the official Python slim image for a smaller, faster build
FROM python:3.11-slim

# Allow statements and log messages to immediately appear in Cloud Logging
ENV PYTHONUNBUFFERED=1

# Set the working directory in the container
WORKDIR /app

# Install system dependencies required for psycopg (Postgres driver)
RUN apt-get update && apt-get install -y libpq-dev gcc && rm -rf /var/lib/apt/lists/*

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of backend code into the container
COPY . .

# Expose the port FastAPI will run on
EXPOSE 8080

# Command to run the web server using Uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]