#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 -u <URL> [-p <PORT>]"
    echo "  -u: URL of the website to be made available offline"
    echo "  -p: Port number to run the website on (default: 8080)"
    exit 1
}

# Default port
PORT=8080

# Parse flags
while getopts ":u:p:" opt; do
    case $opt in
        u)
            URL="$OPTARG"
            ;;
        p)
            PORT="$OPTARG"
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            usage
            ;;
    esac
done

# Check if URL is provided
if [ -z "$URL" ]; then
    echo "URL not provided."
    usage
fi

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Please install Docker from the official website or your package manager."
    exit 1
else
    echo "Docker is already installed."
fi

# Download the website for offline use using wget
echo "Downloading website for offline use..."
mkdir -p website
wget -P website/ --recursive --no-clobber --page-requisites --html-extension --convert-links --restrict-file-names=windows --domains $(echo $URL | awk -F/ '{print $3}') --no-parent $URL

# Create the Dockerfile
cat <<EOF > Dockerfile
# Use the official Nginx image as a base
FROM nginx:alpine

# Copy the downloaded website to the Nginx web root
COPY website/ /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
EOF

# Build the Docker image
echo "Building the Docker image..."
docker build -t offline-website .

# Check if a container with the name "offline-website-container" is already running
if [ "$(docker ps -q -f name=offline-website-container)" ]; then
    echo "Container is already running. Restarting..."
    docker restart offline-website-container
else
    # Run the Docker container
    echo "Running the Docker container on port $PORT..."
    docker run -d -p $PORT:80 --name offline-website-container offline-website
fi

# Verify the container is running
if [ "$(docker ps -q -f name=offline-website-container)" ]; then
    echo "Container is running successfully!"
    echo "You can access the website at http://$(hostname -I | awk '{print $1}'):$PORT"
else
    echo "There was an issue starting the container. Please check the Docker logs for more details."
fi
