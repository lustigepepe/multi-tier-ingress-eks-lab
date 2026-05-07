#!/bin/bash

# ===================== CONFIG =====================
USERNAME="0098765"
VERSION="1.0"                    # Change this when you update your app

echo "🚀 Building and pushing multi-arch images for EKS..."

# ===================== BUILD & PUSH =====================

echo "📦 Building Backend (linux/amd64)..."
docker buildx build --platform linux/amd64 \
  -t $USERNAME/lab-backend:$VERSION \
  -t $USERNAME/lab-backend:latest \
  -f ./backend/Dockerfile \
  --push ./backend

echo "📦 Building Frontend (linux/amd64)..."
docker buildx build --platform linux/amd64 \
  -t $USERNAME/lab-frontend:$VERSION \
  -t $USERNAME/lab-frontend:latest \
  -f ./frontend/Dockerfile \
  --push ./frontend

# ===================== STATUS =====================
if [ $? -eq 0 ]; then
  echo "🎉 Success! Both images built and pushed for AMD64 (EKS compatible)"
  echo "   Tags: $USERNAME/lab-backend:$VERSION"
  echo "         $USERNAME/lab-frontend:$VERSION"
else
  echo "❌ Build or push failed!"
  exit 1
fi