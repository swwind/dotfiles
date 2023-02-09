if [[ $HYPRLAND_INSTANCE_SIGNATURE == "" && $(tty) == "/dev/tty1" ]]; then
	export SDL_VIDEODRIVER=wayland
	export MOZ_ENABLE_WAYLAND=1
	export XCURSOR_SIZE=24
	export QT_QPA_PLATFORMTHEME=qt5ct
	export QT_STYLE_OVERRIDE=kvantum
	export GTK_CSD=0
#  export LIBVA_DRIVER_NAME=nvidia
#  export XDG_SESSION_TYPE=wayland
#  export GBM_BACKEND=nvidia-drm
#  export __GLX_VENDOR_LIBRARY_NAME=nvidia
#  export WLR_NO_HARDWARE_CURSORS=1
	export NVD_BACKEND=direct
	exec Hyprland
fi
