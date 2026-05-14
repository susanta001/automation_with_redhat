#!/usr/bin/env python3

import subprocess

print("[INFO] Starting network diagnostics...")

# Example diagnostics
commands = [
    ["ping", "-c", "2", "8.8.8.8"],
    ["ip", "a"],
    ["ip", "r"]
]

for cmd in commands:
    try:
        output = subprocess.check_output(cmd, stderr=subprocess.STDOUT).decode()
        print(f"[COMMAND] {' '.join(cmd)}")
        print(output)
    except subprocess.CalledProcessError as e:
        print(f"[ERROR] {' '.join(cmd)} failed:\n{e.output.decode()}")

