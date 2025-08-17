#!/bin/bash
IMAGE_NAME="satven/test-app:latest"
CONTAINER_NAME="test-app-container"
docker build -t $IMAGE_NAME .
docker run --rm -d --name $CONTAINER_NAME -p 5000:5000 $IMAGE_NAME
sleep 5
NUM1=5
NUM2=6
RESULT=$((NUM1 + NUM2))
EXPECTED=$(curl -s "http://localhost:5000/add?num1=$NUM1&num2=$NUM2")
if [ "$RESULT" = "$EXPECTED" ]; then
  echo "success"
  exit 0
else
  echo "failure"
  exit 1
fi

