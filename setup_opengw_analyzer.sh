#!/bin/bash

# --- Setup Script for OpenGW Enterprise PSP Analyzer ---
# This script will clone the repository and start a simple Python web server
# to serve the analyzer in your local browser.

REPO_URL="https://github.com/shiuh-yaw/opengw-enterprise-analyzer.git"
APP_DIR="opengw-enterprise-analyzer/opengw-analyzer"
PORT=8000

echo "Starting setup for OpenGW Enterprise PSP Analyzer..."

# 1. Check for Git
if ! command -v git &> /dev/null
then
    echo "Git is not installed. Please install Git first (e.g., sudo apt-get install git or brew install git)."
    exit 1
fi

# 2. Check for Python 3
if ! command -v python3 &> /dev/null
then
    echo "Python 3 is not installed. Please install Python 3 first."
    exit 1
fi

# 3. Clone the repository if it doesn't exist
if [ ! -d "opengw-enterprise-analyzer" ]; then
    echo "Cloning the repository from $REPO_URL..."
    git clone $REPO_URL
    if [ $? -ne 0 ]; then
        echo "Failed to clone repository. Exiting."
        exit 1
    fi
else
    echo "Repository already exists. Pulling latest changes..."
    (cd opengw-enterprise-analyzer && git pull)
    if [ $? -ne 0 ]; then
        echo "Failed to pull latest changes. Exiting.
        exit 1
    fi
fi

# 4. Navigate to the application directory
if [ ! -d "$APP_DIR" ]; then
    echo "Application directory $APP_DIR not found after cloning. Exiting."
    exit 1
fi

cd $APP_DIR

# 5. Start a simple HTTP server
echo "Starting a simple HTTP server on port $PORT..."
echo "You can access the analyzer at: http://localhost:$PORT/index.html"

# Use exec to replace the current shell with the server process
# This means Ctrl+C will stop the server directly
exec python3 -m http.server $PORT

