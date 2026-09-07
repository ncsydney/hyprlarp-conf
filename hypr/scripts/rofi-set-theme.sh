WALLPAPER_BASE_DIR="$HOME/Pictures/backgrounds"

ROFI_INPUT=""
for file in "$WALLPAPER_BASE_DIR"/*; do
    if [ -f "$file" ]; then
        basename=$(basename "$file")
        ROFI_INPUT+="${basename}\0icon\x1f${file}\n"
    fi
done

THEME=$(echo -e "$ROFI_INPUT" | rofi -dmenu -i -show-icons -p "Choose Wallpaper:")

if [ ! -d "$WALLPAPER_BASE_DIR" ]; then
    notify-send "Wallpaper map niet gevonden"
    exit 1
fi

if [ -z "$THEME" ]; then
    exit 0
fi

FULL_PATH="$WALLPAPER_BASE_DIR/$THEME"

# echo $FULL_PATH > $HOME/.config/backgrounds/current_wallpaper
echo "$""FULL_PATH="$FULL_PATH > $HOME/.config/hypr/curwall.conf
ln -sf "$FULL_PATH" "$HOME/.config/backgrounds/current_wallpaper"

waypaper --wallpaper "$FULL_PATH"
matugen image "$FULL_PATH" --source-color-index 0 -c "$HOME/.config/matugen/config.toml"
pkill -SIGUSR2 waybar
notify-send -i "$FULL_PATH" "Wallpaper Changed" "New wallpaper: $THEME"
