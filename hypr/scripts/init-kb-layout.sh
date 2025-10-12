#!/bin/bash

STATE_FILE="$HOME/.config/hypr/current-kb-layout"

# Esperar un poco a que Hyprland esté listo
sleep 2

# Detectar layout actual del sistema
system_layout=$(hyprctl devices | grep "active keymap:" | head -1 | awk '{print $3}')

if [[ "$system_layout" == "Spanish" || "$system_layout" == "es" ]]; then
    echo "es" > "$STATE_FILE"
else
    echo "us" > "$STATE_FILE"
fi

# Actualizar Waybar
pkill -SIGRTMIN+1 waybar