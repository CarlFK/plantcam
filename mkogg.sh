#!/bin/bash -ex

time rsync -rtvp pi@plantcam:plants .
time gst-launch-1.0 multifilesrc location="plants/img%06d.png" index=0 caps="image/png,framerate=30/1" ! pngdec ! videoconvert ! videorate !  theoraenc ! oggmux ! filesink location="_plants.ogg" 
mv --force _plants.ogg plants.ogg
vlc plants.ogg
