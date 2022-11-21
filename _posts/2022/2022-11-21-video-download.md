---
layout: post
title:  "Fixing video/audio synchronization in a downloaded material"
ref:    2022-11-21-video-download
lang:   en
date:   2022-11-21 17:04:33 +02:00
tags:   linux ffmpeg
---

As we've started to be impacted by the power blackouts, we resorted to
downloading videos whenever possible to watch them later when convenient.
The browser addon [Video DownloadHelper](https://www.downloadhelper.net/)
hits right the spot for that. But it turns out that the video frame rate may
be rogue in some cases. There can be a ridiculous number as high as 16k fps.
My solution is to transcode the file forcing the frame rate to the desired
value, which is actually detected correctly by the addon on the web page. In our
case it was 30 FPS. Here's the bash script invoking FFmpeg three times to
extract audio and video tracks, and multiplex them back into an mp4 container:

```bash
#!/bin/bash -e

if [[ $# -lt 1 ]]; then exit 1; fi

fname=$1

extract_video() {
  ffmpeg -loglevel error -i $fname -map 0:v -c:v copy -bsf:v h264_mp4toannexb -f h264 -
}

extract_audio() {
  ffmpeg -loglevel error -i $fname -vn -acodec copy -f adts -
}

ffmpeg -fflags +genpts -r 30 \
  -i <(extract_video) \
  -i <(extract_audio) \
  -map 0:v -c:v copy -map 1:a -movflags faststart $fname-fixed.mp4
```

Anonymous pipes are used here to pass the video and audio streams into the
multiplexing command.
