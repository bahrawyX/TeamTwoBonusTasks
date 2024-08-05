# Stage 1: Builder
FROM python:3.9-alpine as builder

# Set the working directory
WORKDIR /app

# Copy the requirements file
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Stage 2: Final Image
FROM python:3.9-alpine

# Set the working directory
WORKDIR /app

# Copy only the necessary files from the builder stage
COPY --from=builder /app /app

# Remove any build artifacts and caches
RUN rm -rf /root/.cache

# Expose the port your app runs on
EXPOSE 5000

# Command to run the application
CMD ["python", "lms.py"]