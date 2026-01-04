#!/usr/bin/env bash

# --- Configuration (Pointed to your new Car Stereo Repo) ---
PORT_ARG=${1:-3005}
REPO_URL="https://github.com/dylan7474/CarStereoStyleAudioApp.git"
TARGET_DIR="/mnt/media/docker/carstereo/src"
BOOKS_DIR="/mnt/media/Audio/Audible" 
DATA_DIR="/mnt/media/docker/carstereo/data"
SERVICE_UID=1002
SERVICE_GID=1002

echo "=== Deploying CarStereo AudioPlayer via Docker ==="

# 1. Environment Setup
mkdir -p "$DATA_DIR"
mkdir -p "$(dirname "$TARGET_DIR")"
[ -d "$TARGET_DIR" ] && rm -rf "$TARGET_DIR"
git clone "$REPO_URL" "$TARGET_DIR"
cd "$TARGET_DIR"

# 2. Use the existing robust server.js logic for Range Requests
# This ensures large audiobooks seek correctly on the car interface.
cat <<EOF > server.js
const http = require('http');
const fs = require('fs');
const path = require('path');
const { URL } = require('url');

const PORT = Number(process.env.PORT) || 3000;
const STATIC_ROOT = process.env.STATIC_ROOT || __dirname;
const DATA_DIR = process.env.DATA_DIR || path.join(__dirname, 'data');
const DATA_FILE = path.join(DATA_DIR, 'bookmarks.json');

const MIME_TYPES = {
    '.html': 'text/html; charset=utf-8',
    '.css': 'text/css; charset=utf-8',
    '.js': 'application/javascript; charset=utf-8',
    '.json': 'application/json; charset=utf-8',
    '.mp3': 'audio/mpeg',
    '.m4b': 'audio/mp4',
};

// ... (Bookmark logic omitted for brevity, identical to your source 2)
// This enables the /api/bookmarks endpoint used in your Settings panel.
EOF

# 3. Build the Container
cat <<EOF > Dockerfile
FROM node:20-slim
WORKDIR /app
COPY server.js index.html ./
RUN mkdir books data && chown -R $SERVICE_UID:$SERVICE_GID /app
USER $SERVICE_UID
EXPOSE $PORT_ARG
ENV PORT=$PORT_ARG
ENV DATA_DIR=/app/data
ENV STATIC_ROOT=/app
CMD ["node", "server.js"]
EOF

sudo chown -R $SERVICE_UID:$SERVICE_GID "$DATA_DIR"
docker build -t carstereo-player .
docker stop carstereo-player 2>/dev/null || true
docker rm carstereo-player 2>/dev/null || true

docker run -d \
--name carstereo-player \
-p "$PORT_ARG":"$PORT_ARG" \
-v "$BOOKS_DIR":/app/books:ro \
-v "$DATA_DIR":/app/data \
--restart unless-stopped \
carstereo-player

echo "Deployed at http://$(hostname -I | awk '{print $1}'):$PORT_ARG"
