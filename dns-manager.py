#!/usr/bin/env python3

import os

print("[INFO] Configuring DNS...")

resolv_conf = "/etc/resolv.conf"
dns_servers = ["8.8.8.8", "1.1.1.1"]

try:
    with open(resolv_conf, "w") as f:
        for dns in dns_servers:
            f.write(f"nameserver {dns}\n")
    print(f"[SUCCESS] DNS servers updated: {', '.join(dns_servers)}")
except Exception as e:
    print(f"[ERROR] Failed to write to {resolv_conf}: {e}")

