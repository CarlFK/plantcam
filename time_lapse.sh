#!/bin/bash -ex
# time_lapse.sh

# /GstPipeline:pipeline0/GstXvImageSink:xvimagesink0.GstPad:sink: caps = video/x-raw, format=(string)YUY2, width=(int)1280, height=(int)720, pixel-aspect-ratio=(fraction)1/1, interlace-mode=(string)progressive, framerate=(fraction)10/1

#  caps = video/x-raw, format=(string)YUY2, width=(int)640, height=(int)480, pixel-aspect-ratio=(fraction)1/1, interlace-mode=(string)progressive, framerate=(fraction)30/1


# gst-launch-1.0 -v v4l2src ! xvimagesink

gst-launch-1.0 -v \
    v4l2src device=/dev/video1 ! \
    video/x-raw, framerate=30/1, format=YUY2 ! \
    videoconvert ! \
    timeoverlay halignment=right valignment=top ! \
    clockoverlay halignment=left valignment=top time-format="%Y/%m/%d %H:%M:%S" ! \
    tee name="splitter" ! queue ! xvimagesink sync=false splitter. ! \
    queue ! \
    videorate ! \
    video/x-raw, format=YUY2, framerate=1/5 ! \
    videoconvert ! \
    pngenc snapshot=false ! \
    multifilesink location=timelapse/%05d.png
    xvimagesink
exit


exit
# swapping v4l2src for videotestsrc
gst-launch-1.0 videotestsrc ! video/x-raw, format=I420, framerate=25/1, width=640, height=480 ! \
    videoconvert ! \
    timeoverlay halignment=right valignment=top ! clockoverlay halignment=left valignment=top time-format="%Y/%m/%d %H:%M:%S" ! \
    tee name="splitter" ! queue ! xvimagesink sync=false splitter. ! \
    queue ! videorate ! video/x-raw, format=I420, \
    framerate=5/1 ! videoconvert ! pngenc snapshot=false ! multifilesink location=timelapse/%05d.png

