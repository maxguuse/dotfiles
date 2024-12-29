#!/usr/bin/env bash

N=15

workspaces=$(hyprctl clients -j | jq --arg n "$N" -r '
  group_by(.workspace.name) | 
  map({
    (.[0].workspace.name): map(
      .initialTitle | split(" ")[0]
    )
  }) | 
  .[] | 
  "\(. | keys[0]). \(.[] | join(", "))" | 
  if length > ($n | tonumber) 
  then .[0:($n | tonumber)] + "..." 
  else . 
  end
')

choice=$(echo "$workspaces" | tofi --prompt-text 'focus: ' --font /usr/share/fonts/TTF/FiraCodeNerdFontMono-Medium.ttf)
if [[ -z "$choice" ]]; then
	exit
fi

number="${choice%%.*}"
hyprctl dispatch focusworkspaceoncurrentmonitor $number
