#!/bin/bash

echo "[INFO] Starting dummy interface configuration..."

# Check if dummy module is loaded
if ! lsmod | grep -q dummy; then
    echo "[INFO] Loading dummy kernel module..."
    modprobe dummy
    if [ $? -ne 0 ]; then
        echo "[ERROR] Failed to load dummy module. Are you root?"
        exit 1
    fi
else
    echo "[INFO] Dummy module already loaded."
fi

# Create dummy interface dummy0
ip link add dummy0 type dummy 2>/dev/null
if [ $? -eq 0 ]; then
    echo "[INFO] Dummy interface dummy0 created."
else
    echo "[WARNING] dummy0 already exists or failed to create."
fi

# Assign IP address to dummy0
ip addr add 192.168.100.1/24 dev dummy0 2>/dev/null
if [ $? -eq 0 ]; then
    echo "[INFO] Assigned IP 192.168.100.1/24 to dummy0."
else
    echo "[WARNING] IP may already be assigned or failed to set."
fi

# Bring interface up
ip link set dummy0 up
if [ $? -eq 0 ]; then
    echo "[SUCCESS] Dummy interface dummy0 is up and ready."
else
    echo "[ERROR] Failed to bring up dummy0."
fi

