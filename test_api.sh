#!/bin/bash
IMAGE_NAME="satven/test-app:latest"
CONTAINER_NAME="test-app-container"
docker build -t $IMAGE_NAME .
docker run -d --name $CONTAINER_NAME -p 5000:5000 $IMAGE_NAME

echo "Waiting for the Flask app to be ready..."
for i in {1..15}; do
  if curl -s http://localhost:5000/health >/dev/null; then
    echo "Flask app is up!"
    break
  fi
  echo "Waiting for app... ($i)"
  sleep 2
done
EXPECTED="30"
RESULT=$(curl -s "http://localhost:5000/add?num1=10&num2=20")

echo "RESULT=$RESULT"
echo "EXPECTED=$EXPECTED"

if [ "$RESULT" = "$EXPECTED" ]; then
  echo "success"
  exit 0
else
  echo "failure"
  exit 1
fi

