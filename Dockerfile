# Use Node.js LTS base image
FROM node:18

# Set working directory inside container
WORKDIR /app

# Copy package.json and package-lock.json first (for faster builds)
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy rest of the application code
COPY . .

# Expose application port (change if your app runs on different port)
EXPOSE 8080

# Start the app
CMD ["npm", "start"]


