# Use the official Nginx image as the base image
FROM nginx:latest

# Copy your Nginx configuration file into the container
COPY nginx.conf /etc/nginx/nginx.conf

# Copy your static files (e.g., HTML, CSS, JavaScript) to the Nginx default serving directory
COPY ./build/berlinics.de /usr/share/nginx/html

# Expose the default Nginx port (usually 80)
EXPOSE 80

# Start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]
