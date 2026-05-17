#!/usr/bin/env bash

# Check if we have internet connectivity
check_internet() {
    ping -c 1 -W 2 8.8.8.8 &>/dev/null
    return $?
}

# Get WiFi info
get_wifi_info() {
    local device=$(nmcli -t -f DEVICE,TYPE device | grep wifi | cut -d: -f1 | head -n1)
    if [ -n "$device" ]; then
        local ssid=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
        local signal=$(nmcli -t -f active,signal dev wifi | grep '^yes' | cut -d: -f2)
        echo "$ssid|$signal"
    fi
}

# Get ethernet info
get_ethernet_info() {
    local device=$(nmcli -t -f DEVICE,TYPE device | grep ethernet | cut -d: -f1 | head -n1)
    if [ -n "$device" ]; then
        local state=$(nmcli -t -f DEVICE,STATE device | grep "^$device" | cut -d: -f2)
        echo "$state"
    fi
}

# Determine connection type and status
wifi_info=$(get_wifi_info)
ethernet_info=$(get_ethernet_info)

if [ -n "$ethernet_info" ] && [ "$ethernet_info" = "connected" ]; then
    icon="󰈀"
    # text="Ethernet"
    class="ethernet"
elif [ -n "$wifi_info" ]; then
    ssid=$(echo "$wifi_info" | cut -d'|' -f1)
    signal=$(echo "$wifi_info" | cut -d'|' -f2)
    
    if [ "$signal" -ge 75 ]; then
        icon="󰤨"
    elif [ "$signal" -ge 50 ]; then
        icon="󰤥"
    elif [ "$signal" -ge 25 ]; then
        icon="󰤢"
    else
        icon="󰤟"
    fi
    
    # text="$ssid"
    class="wifi"
else
    icon="󰤮"
    text=""
    class="disconnected"
fi

# Check actual internet connectivity
if check_internet; then
    tooltip="Connected to: $text\nInternet: Available"
else
    tooltip="Connected to: $text\nInternet: No connection"
    class="no-internet"
fi

# Output in JSON format
echo "{\"text\":\"$icon $text\",\"tooltip\":\"$tooltip\",\"class\":\"$class\"}"
