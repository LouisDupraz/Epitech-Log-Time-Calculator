#!/bin/sh

#echo "stream.sh started" >> "/home/LouisD/scripts/nw_activity.log";
tmux new -d "cvlc --no-audio 'https://www.youtube.com/watch?v=jfKfPfyJRdk' -V dummy"
exit 0
