#!/bin/bash
# Robust Ambient Script for Niri & ImageMagick v7
while true; do
    # 1. Capture screen with grim
    # 2. Rescale to 1x1 to average color
    # 3. Use 'magick' to output raw RGB values
    RGB_DATA=$(grim - 2>/dev/null | magick - -resize 1x1\! -format "%[pixel:up{}]" info: 2>/dev/null)

    # If output is "rgb(255,0,0)", extract just the numbers "255,0,0"
    RGB_VALS=$(echo "$RGB_DATA" | sed -E 's/rgb\((.*)\)/\1/')

    if [[ "$RGB_VALS" =~ ^[-]+,[-]+,[-]+$ ]]; then
        # Construct the 12-value string (3 colors * 4 zones)
        ZONE_STRING="${RGB_VALS},${RGB_VALS},${RGB_VALS},${RGB_VALS}"

        # Apply using the Static effect
        legion-kb-rgb set -e Static -c "$ZONE_STRING" >/dev/null 2>&1
    fi

    # 100ms delay to keep it stable
    sleep 0.1
done
