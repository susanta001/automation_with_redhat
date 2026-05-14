#!/bin/bash

echo "[+] Installing iptables-services..."
sudo yum install -y iptables-services

echo "[+] Disabling firewalld..."
sudo systemctl stop firewalld
sudo systemctl disable firewalld

echo "[+] Enabling iptables..."
sudo systemctl enable iptables
sudo systemctl start iptables

echo "[+] Flushing existing iptables rules..."
sudo iptables -F

echo "[+] Allowing ports: 22, 80, 443"
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT

echo "[+] Blocking ports: 23, 8080"
sudo iptables -A INPUT -p tcp --dport 23 -j DROP
sudo iptables -A INPUT -p tcp --dport 8080 -j DROP

echo "[+] Dropping all other traffic"
sudo iptables -A INPUT -j DROP

echo "[+] Saving rules and restarting iptables"
sudo service iptables save
sudo systemctl restart iptables

echo "[+] Current iptables rules:"
sudo iptables -L -n

