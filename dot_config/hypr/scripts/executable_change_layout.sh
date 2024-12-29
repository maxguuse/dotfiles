# notif="$HOME/.config/swaync/images/bell.png"

LAYOUT=$(hyprctl -j getoption general:layout | jq '.str' | sed 's/"//g')

case $LAYOUT in
"master")
	hyprctl keyword general:layout dwindle
	hyprctl keyword unbind SUPER,J
	hyprctl keyword unbind SUPER,K
	hyprctl keyword unbind SUPER ALT,H
	hyprctl keyword unbind SUPER ALT,K
	hyprctl keyword unbind SUPER ALT,J
	hyprctl keyword bind SUPER,J,movefocus,d
	hyprctl keyword bind SUPER,K,movefocus,u
	hyprctl keyword bind SUPER,O,togglesplit
  # notify-send -e -u low -i "$notif" "Dwindle Layout"
	;;
"dwindle")
	hyprctl keyword general:layout master
	hyprctl keyword unbind SUPER,J
	hyprctl keyword unbind SUPER,K
	hyprctl keyword unbind SUPER,O
	hyprctl keyword bind SUPER,J,layoutmsg,cyclenext
	hyprctl keyword bind SUPER,K,layoutmsg,cycleprev
	hyprctl keyword bind SUPER ALT,H,layoutmsg,swapwithmaster master
	hyprctl keyword bind SUPER ALT,K,layoutmsg,addmaster
	hyprctl keyword bind SUPER ALT,J,layoutmsg,removemaster
  # notify-send -e -u low -i "$notif" "Master Layout"
	;;
*) ;;

esac
