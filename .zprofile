if [[ $HYPRLAND_INSTANCE_SIGNATURE == "" && $(tty) == "/dev/tty1" ]]; then
	export SDL_VIDEODRIVER=wayland
	export MOZ_ENABLE_WAYLAND=1
	export XCURSOR_SIZE=24
	export QT_QPA_PLATFORMTHEME=qt5ct
	export QT_STYLE_OVERRIDE=kvantum
	export GTK_CSD=0
	export NVD_BACKEND=direct
	exec Hyprland
fi
