#!/bin/bash

card=$(pacmd list-cards | grep -B 1 bluez)
is_a2dp_sink=$(echo $card | grep a2dp_sink)
index=${card:10:2}

sink=$( pacmd list-cards | grep bluez )
mac=${sink:19:17}
bt_sink="bluez_sink.$mac"
bt_source="bluez_source.$mac"

if [[ "$is_a2dp_sink" ]]
then
	pacmd set-card-profile 4 headset_head_unit
	notify-send -t 30000 "Headphone profile changed" "New profile: HSP"
else
	pacmd set-card-profile 4 a2dp_sink
	pacmd set-default-sink "$bt_sink.a2dp_sink"
	notify-send -t 30000 "Headphone profile changed" "New profile: A2SP"
fi
