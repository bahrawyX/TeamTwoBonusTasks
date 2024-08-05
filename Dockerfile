# Stage 1: Builder
FROM python:3.9-slim as builder

# Set the working directory
WORKDIR /app

# Copy only the necessary files
COPY requirements.txt .
RUN pip install --no-cache-dir --target=/app/deps -r requirements.txt

# Copy the rest of the application code
COPY lms.py books.json /app/
COPY templates /app/templates

# Remove unnecessary files and caches
RUN rm -rf /root/.cache

# Stage 2: Final Image
FROM python:3.9-alpine

# Set the working directory
WORKDIR /app

# Copy only the necessary files from the builder stage
COPY --from=builder /app /app

# Expose the port your app runs on
EXPOSE 5000

# Command to run the application
CMD ["python", "lms.py"]
