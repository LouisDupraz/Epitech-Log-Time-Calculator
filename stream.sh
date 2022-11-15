#!/bin/sh

tmux new -d "cvlc 'https://www.youtube.com/watch?v=jfKfPfyJRdk' -V dummy"
sleep 10
app_name="VLC media player (LibVLC $(pactl list sink-inputs | grep 'application.name = ' | cut -d\( -f2 | cut -d\) -f1 | cut -dC -f2 | tr -d ' '))"

current_sink_num=''
sink_num_check=''
app_name_check=''

pactl list sink-inputs |while read line; do \
    sink_num_check=$(echo "$line" |sed -rn 's/^Sink Input #(.*)/\1/p')
    if [ "$sink_num_check" != "" ]; then
        current_sink_num="$sink_num_check"
    else
        app_name_check=$(echo "$line" \
            |sed -rn 's/application.name = "([^"]*)"/\1/p')
        if [ "$app_name_check" = "$app_name" ]; then
            pactl set-sink-input-mute "$current_sink_num" toggle
        fi
    fi
done

exit 0
