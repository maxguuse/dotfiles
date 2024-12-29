iDIR="$HOME/.config/swaync/icons"

get_volume() {
	wpctl get-volume @DEFAULT_AUDIO_SINK@
}

get_mic_volume() {
	wpctl get-volume @DEFAULT_AUDIO_SOURCE@
}

get_icon() {
    current=$(get_volume)
    if [[ $current == *"MUTED"* ]]; then
        echo "$iDIR/volume-mute.png"
    elif (( $(echo "$(echo $current | cut -d' ' -f2) <= 0.3" | bc -l) )); then
        echo "$iDIR/volume-low.png"
    elif (( $(echo "$(echo $current | cut -d' ' -f2) <= 0.6" | bc -l) )); then
        echo "$iDIR/volume-mid.png"
    else
        echo "$iDIR/volume-high.png"
    fi
}

# Increase Volume
inc_volume() {
	if [[ $(get_volume) == *"MUTED"* ]]; then
        toggle_mute
    else
        wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+ && notify_user
    fi
}

# Decrease Volume
dec_volume() {
    if [[ $(get_volume) == *"MUTED"* ]]; then
        toggle_mute
    else
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && notify_user
    fi
}

# Toggle Mute
toggle_mute() {
    if [[ $(get_volume) == *"MUTED"* ]]; then
		wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && notify-send -e -u low -i $(get_icon) "Volume Switched ON: $(echo $(get_volume) | cut -d' ' -f2)"
	else
		wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && notify-send -e -u low -i $(get_icon) "Volume Switched OFF"
	fi
}

# Toggle Mic
toggle_mic() {
	if [[ $(get_mic_volume) == *"MUTED"* ]]; then
		wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && notify-send -e -u low -i "$iDIR/microphone.png" "Microphone Switched ON"
	else
		wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && notify-send -e -u low -i "$iDIR/microphone.png" "Microphone Switched OFF"
	fi

}

notify_user() {
    if [[ $(get_volume) == *"MUTED"* ]]; then
        notify-send -e -h string:x-canonical-private-synchronous:volume_notif -u low -i $(get_icon) "Volume: Muted"
    else
		notify-send -e -h int:value:"$(echo "$(cut -d' ' -f2 <<< $(get_volume)) * 100" | bc -l)" -h string:x-canonical-private-synchronous:volume_notif -u low $(get_volume) -i $(get_icon)
    fi
}

# Execute accordingly
if [[ "$1" == "--inc" ]]; then
	inc_volume
elif [[ "$1" == "--dec" ]]; then
	dec_volume
elif [[ "$1" == "--toggle" ]]; then
	toggle_mute
elif [[ "$1" == "--toggle-mic" ]]; then
	toggle_mic
else
	echo $(get_volume)
fi
