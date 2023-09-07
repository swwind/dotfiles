if [[ $HYPRLAND_INSTANCE_SIGNATURE == "" && $(tty) == "/dev/tty1" ]]; then
	exec Hyprland
fi
