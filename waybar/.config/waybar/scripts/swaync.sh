#!/usr/bin/env bash

COUNT=$(swaync-client -c)
DND=$(swaync-client -D)

# Do Not Disturb enabled
if [ "$DND" = "true" ]; then
  echo '{"text":"󰂛","tooltip":"Do not disturb enabled","class":"dnd"}'
  exit 0
fi

# No notifications | icon only
if [ "$COUNT" -eq 0 ]; then
  echo '{"text":"󰂜","tooltip":"No notifications","class":"empty"}'
  # echo '{"text":"","tooltip":"No notifications","class":"empty"}'
  # echo '{"text":"󰂚","tooltip":"No notifications","class":"empty"}'
  exit 0
fi

# Has notifications | icon + number
# echo "{\"text\":\"\",\"tooltip\":\"Notifications: $COUNT\",\"class\":\"filled\"}"
echo "{\"text\":\"󱅫\",\"tooltip\":\"Notifications: $COUNT\",\"class\":\"filled\"}"

