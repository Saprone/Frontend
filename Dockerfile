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

# Create a non-root user and group
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy the built application from the builder stage to Nginx
COPY --from=builder /app/dist /usr/share/nginx/html

# Change ownership of the Nginx html directory to the non-root user
RUN chown -R appuser:appgroup /usr/share/nginx/html

# Switch to the non-root user
USER appuser

# Expose the application port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]