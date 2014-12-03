#!/bin/bash -ex
# time_lapse.sh

# gst-launch-1.0 -v v4l2src ! xvimagesink

gst-launch-1.0 -v \
    v4l2src device=/dev/video0 ! \
    video/x-raw, framerate=30/1, format=YUY2 ! \
    videoconvert ! \
    timeoverlay halignment=right valignment=top ! \
    clockoverlay halignment=left valignment=top time-format="%Y/%m/%d %H:%M:%S" ! \
    queue ! \
    videorate ! \
    video/x-raw, format=YUY2, framerate=1/5 ! \
    videoconvert ! \
    pngenc snapshot=false ! \
    multifilesink location=timelapse/%05d.png
    xvimagesink

exit

    tee name="splitter" ! queue ! xvimagesink sync=false splitter. ! \

exit
# swapping v4l2src for videotestsrc
gst-launch-1.0 videotestsrc ! video/x-raw, format=I420, framerate=25/1, width=640, height=480 ! \
    videoconvert ! \
    timeoverlay halignment=right valignment=top ! clockoverlay halignment=left valignment=top time-format="%Y/%m/%d %H:%M:%S" ! \
    tee name="splitter" ! queue ! xvimagesink sync=false splitter. ! \
    queue ! videorate ! video/x-raw, format=I420, \
    framerate=5/1 ! videoconvert ! pngenc snapshot=false ! multifilesink location=timelapse/%05d.png

