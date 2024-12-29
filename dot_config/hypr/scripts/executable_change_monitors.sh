vars=("Dual" "External" "Internal")
choice=$(printf '%s\n' "${vars[@]}" | tofi --prompt-text 'focus: ' --font /usr/share/fonts/TTF/FiraCodeNerdFontMono-Medium.ttf)
if [[ -z "$choice" ]]; then
	exit
fi

if [[ "$choice" == "Dual" ]]; then
	echo "\$config = /home/ggoose/.config/hypr/configs/dual-monitors" > /home/ggoose/.config/hypr/configs/monitors.conf
	echo "source = \$config/monitors.conf" >> /home/ggoose/.config/hypr/configs/monitors.conf
	echo "source = \$config/workspaces.conf" >> /home/ggoose/.config/hypr/configs/monitors.conf
elif [[ "$choice" == "External" ]]; then
	echo "\$config = /home/ggoose/.config/hypr/configs/external-monitor" > /home/ggoose/.config/hypr/configs/monitors.conf
	echo "source = \$config/monitors.conf" >> /home/ggoose/.config/hypr/configs/monitors.conf
	echo "source = \$config/workspaces.conf" >> /home/ggoose/.config/hypr/configs/monitors.conf
elif [[ "$choice" == "Internal" ]]; then
	echo "\$config = /home/ggoose/.config/hypr/configs/internal-monitor" > /home/ggoose/.config/hypr/configs/monitors.conf
	echo "source = \$config/monitors.conf" >> /home/ggoose/.config/hypr/configs/monitors.conf
	echo "source = \$config/workspaces.conf" >> /home/ggoose/.config/hypr/configs/monitors.conf
fi

hyprctl reload
