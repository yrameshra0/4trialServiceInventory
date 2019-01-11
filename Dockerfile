# Using official python runtime base image
FROM ubuntu:18.04

# Set the application directory
WORKDIR /app

# Copy our files from the current folder to /app inside the container
ADD . /app

# Install our requirements.txt
RUN /app/prepare.sh

# Define our command to be run when launching the container
CMD ["sh", "/app/init.sh"]