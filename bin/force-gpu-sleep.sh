#!/bin/bash
# Wait 10 seconds for Niri and desktop portals to finish their startup checks
sleep 10

# Force the main GPU and its audio device into automatic power management
echo "auto" | sudo tee /sys/bus/pci/devices/0000:01:00.0/power/control
echo "auto" | sudo tee /sys/bus/pci/devices/0000:01:00.1/power/control
