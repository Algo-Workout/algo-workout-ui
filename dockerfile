# Use a base image with Node.js installed
FROM node:20 as build

# Set working directory
WORKDIR /app

# Copy the package.json and package-lock.json to install dependencies
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the React application
RUN npm run build

# Use a lightweight web server to serve the build files
# Nginx is a high performance web server commonly used to serve static files and handle web traffic.
# ^Top part of the Dockerfile, using Node image to install dependencies and run the build command for React. This produces static files (HTML, CSS, JS) into a 'dist' folder.
# We'll use Nginx to serve these files, which is much more efficient than running something like `npm start` 
FROM nginx:alpine

# Copy the build output from the previous step
# '/usr/share/nginx/html' is the default location where Nginx will look for files to serve
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx when the container launches
# CMD is the default command to run when the container starts. There can be only one 'CMD' per Dockerfile, and it will override any previous 'CMD' instructions if there are multiple.
# The array style syntax is to direct Nginx to run in the foregound within the container, which is essential for keeping the container serving our application as long as it's active.
CMD ["nginx", "-g", "daemon off;"]
