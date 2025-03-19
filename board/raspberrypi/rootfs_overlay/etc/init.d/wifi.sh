#!/bin/sh
# Start WiFi using wpa_supplicant and get an IP via DHCP

# Start wpa_supplicant in the background on wlan0 with the configuration file
/sbin/wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant.conf

# Wait a few seconds for the connection to establish
sleep 5

# Request an IP address using DHCP (using udhcpc)
/sbin/udhcpc -i wlan0
