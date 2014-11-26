#!/bin/bash -x
# e

time rsync -rtvp pi@plantcam:plants .
time gst-launch-1.0 multifilesrc location="plants/img%06d.png" index=0 caps="image/png,framerate=60/1" ! pngdec ! videoconvert ! videorate !  theoraenc ! oggmux ! filesink location="_plants.ogv" 
mv --force _plants.ogv plants.ogv
# cp plants.ogv ~/Dropbox/Public/plants
vlc plants.ogv
