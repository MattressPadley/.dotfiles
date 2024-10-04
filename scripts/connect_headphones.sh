#!/bin/bash

# Number of attempts to connect
max_attempts=3
attempt=1

# Attempt to connect to the Bluetooth device
while [ $attempt -le $max_attempts ]; do
  echo "Attempt $attempt of $max_attempts: Connecting to Bluetooth device..."
  blueutil --disconnect 90-9c-4a-d7-5d-cf
  blueutil --connect 90-9c-4a-d7-5d-cf

  # Check if the connection was successful
  if [ $? -eq 0 ]; then
    echo "Connected to device. Switching audio source..."
    SwitchAudioSource -s "Outputs" || echo "Failed to switch to Outputs"
    exit 0
  else
    echo "Failed to connect to Bluetooth device. Retrying..."
    ((attempt++))
    sleep 2  # Wait for 2 seconds before retrying
  fi
done

echo "Failed to connect to Bluetooth device after $max_attempts attempts."