# Use the official Node.js runtime as the base image
# We're using version 22.8.0 with Alpine Linux for a smaller footprint
FROM node:22.8.0-alpine

# Set the working directory in the container to /app
# All subsequent commands will be run from this directory
WORKDIR /app 

# Copy package.json and package-lock.json (if available) to the working directory
# This is done before copying the rest of the files to take advantage of Docker's cache
# If the package files haven't changed, Docker will use the cached dependencies
COPY package*.json ./

# Install the project dependencies
# This will read the package.json file and install all listed dependencies
RUN npm install

# Copy the rest of the application's source code from the host to the container
# The first . represents the source (everything in the current directory on the host)
# The second . represents the destination (the current working directory in the container, which is /app)
COPY . .

# Specify the command to run when the container starts
# This will run the 'dev' script defined in your package.json
# Using the array syntax is the preferred method for CMD as it avoids issues with shell parsing
CMD ["npm", "run", "dev"]