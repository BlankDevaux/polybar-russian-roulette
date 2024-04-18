#!/bin/bash
#
# Retrieves open windows.
# When $CMD is --shoot, kills one open window randomly.

readonly CMD=$1

function get_random_window() {
  mapfile open_windows < <(wmctrl -l | awk '{print $1}')
  echo "${open_windows[ $RANDOM % ${#open_windows[@]} ]}"
}

function get_window_name() {
  echo "$(xdotool getwindowname $1)"
}

function kill_window() {
  window_count_for_pid=$(xdotool search --pid $(xdotool getwindowpid $1) | wc -l)
  if [ window_count_for_pid > 1 ];
  then
    wmctrl -ic $1
  else
    xkill -id $1
  fi
}

function shoot() {
  random_window=$(get_random_window)
  window_name=$(get_window_name $random_window)
  
  $(kill_window $random_window)
  
  dunstify --appname="roulette" --urgency="CRITICAL" "Killed $window_name"
}

case $CMD in
  "--shoot")
    shoot
  ;;

  *)
    get_open_windows
  ;;
esac
