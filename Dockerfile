# Use Node.js as the base image to build the app
FROM node:18-alpine AS builder

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json first (for better caching)
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install --frozen-lockfile

# Copy all project files to the container
COPY . .

# Build the React app
RUN npm run build

# Use Nginx for serving the static files
FROM nginx:alpine

# Set the working directory
WORKDIR /usr/share/nginx/html

# Remove the default Nginx static files
RUN rm -rf ./*

# Copy built files from the builder stage
COPY --from=builder /app/build ./

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
