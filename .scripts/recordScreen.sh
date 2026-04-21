#!/bin/sh
# Use hacksaw to select a window or area
selection=$(hacksaw)

# Parse the geometry (WidthxHeight+X+Y)
IFS=+x read -r w h x y <<EOF
$selection
EOF

# Ensure width and height are even (required by most encoders like x264), round them down to keep it inside the screen boundarie.
w=$((w - w % 2))
h=$((h - h % 2))

# Record using ffmpeg
ffmpeg \
  -f x11grab \
  -draw_mouse 0 \
  -video_size "${w}x${h}" \
  -i ":0.0+$x,$y" \
  -c:v libx264 -preset ultrafast -crf 0 \
  -pix_fmt yuv420p \
  -movflags +faststart \
  "recording_$(date +%Y%m%d_%H%M%S).mp4"
