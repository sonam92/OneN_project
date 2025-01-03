# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /one2N

# Copy the current directory contents into the container
COPY . /one2N

# Install the required Python packages
RUN pip install --no-cache-dir flask boto3

# Expose the port the app runs on (default Flask port is 5000)
EXPOSE 5000

# Define environment variable for Flask
ENV FLASK_APP=http_service.py

# Command to run the application
CMD ["flask", "run", "--host=0.0.0.0"]
