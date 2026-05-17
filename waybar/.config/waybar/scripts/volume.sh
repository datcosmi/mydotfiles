#!/usr/bin/env bash
VALUE=5

print-usage() {
  local script=${0##*/}
  cat <<-EOF
USAGE: $script [OPTIONS]
Adjust default device volume and show swayosd feedback
OPTIONS:
    input            Control microphone
    output           Control speakers
    mute             Toggle mute
    raise <value>    Raise volume by <value>
    lower <value>    Lower volume by <value>
                        Default value: $VALUE
EXAMPLES:
    $script input mute
    $script output raise
    $script output lower 5
EOF
  exit 1
}

main() {
  device=$1
  action=$2
  value=${3:-$VALUE}

  case $device in
  input)
    VOL_CMD="--input-volume"
    MUTE_CMD="--input-volume"
    ;;
  output)
    VOL_CMD="--output-volume"
    MUTE_CMD="--output-volume"
    ;;
  *)
    print-usage
    ;;
  esac

  case $action in
  mute)
    swayosd-client "$MUTE_CMD" mute-toggle
    ;;
  raise)
    swayosd-client "$VOL_CMD" "+$value"
    ;;
  lower)
    swayosd-client "$VOL_CMD" "-$value"
    ;;
  *)
    print-usage
    ;;
  esac
}

main "$@"
