# Use a base image for Node.js
FROM node:16 AS builder

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json for dependency installation
COPY package*.json ./

# Install dependencies
RUN npm install --ignore-scripts

# Copy the rest of the application source code
COPY . .

# Build the Vue.js application
RUN npm run build

# Use a new image to serve the application
FROM nginx:alpine

# Copy the built application from the builder stage to Nginx
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose the application port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]