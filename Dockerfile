# Step 1: Start from an official Python base image (slim = smaller size)
FROM python:3.11-slim

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy requirements first (allows Docker to cache this layer)
COPY requirements.txt .

# Step 4: Install Python dependencies
RUN pip install --no-cache-dir --upgrade pip setuptools wheel && \
    pip install --no-cache-dir -r requirements.txt


# Step 5: Copy the rest of the application code
COPY . .

# Step 6: Tell Docker the app listens on port 5000
EXPOSE 5000

# Step 7: Command to run when the container starts
CMD ["python3", "app.py"]

