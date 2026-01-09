#!/usr/bin/env bash
#
# Launch a power menu
#
# Requirement: wofi
#
# Author:  Jesse Mirabel <sejjymvm@gmail.com>
# Date:    August 19, 2025
# License: MIT

# shellcheck disable=SC1090
main() {
	local list=(
		"Lock"
		"Shutdown"
		"Reboot"
		"Logout"
		"Hibernate"
		"Suspend"
	)

	local selected
	selected=$(printf "%s\n" "${list[@]}" | wofi --dmenu --prompt "Power Menu")

	case $selected in
		"Lock") loginctl lock-session ;;
		"Shutdown") systemctl poweroff ;;
		"Reboot") systemctl reboot ;;
		"Logout") loginctl terminate-session "$XDG_SESSION_ID" ;;
		"Hibernate") systemctl hibernate ;;
		"Suspend") systemctl suspend ;;
		*) exit 1 ;;
	esac
}

main
