folder="/home/ggoose/Pictures/Wallpapers"
wallpaper=$(/bin/ls $folder | shuf -n 1)

pkill hyprpaper
echo "preload = $folder/$wallpaper" > /home/ggoose/.config/hypr/hyprpaper.conf
echo "wallpaper = , $folder/$wallpaper" >> /home/ggoose/.config/hypr/hyprpaper.conf
hyprpaper
