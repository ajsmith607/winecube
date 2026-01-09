#!/bin/bash

# Focus the OpenSCAD window
xdotool search --onlyvisible --class openscad windowactivate

# Simulate the keystrokes to save an image
xdotool key ctrl+s  # Replace with the actual keystroke sequence for 'Save Image As...'
sleep 1             # Wait for the Save dialog to open

# Type the filename and press Enter
xdotool type '/path/to/save/image.png'  # Replace with your desired file path
xdotool key Return

# Optional: Close the Save As dialog if necessary
# xdotool key Escape
