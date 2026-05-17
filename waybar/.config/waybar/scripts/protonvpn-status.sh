#!/usr/bin/env bash

if ip link show pvpn0 > /dev/null 2>&1 || \
   ip link show proton0 > /dev/null 2>&1 || \
   ip link show tun0 > /dev/null 2>&1; then

    IP=$(ip -4 addr show pvpn0 proton0 tun0 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -n 1)

    echo "{\"text\": \"\", \"tooltip\": \"VPN Connected\", \"class\": \"vpn-on\"}"

else
    echo "{\"text\": \" \", \"tooltip\": \"No VPN\", \"class\": \"vpn-off\"}"
fi
