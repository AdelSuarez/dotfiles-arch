#!/bin/bash

STATE_FILE="$HOME/.config/hypr/current-kb-layout"

# Función para obtener layout actual del sistema
get_system_layout() {
    hyprctl devices | grep "active keymap:" | head -1 | awk '{print $3}'
}

# Función para guardar layout
save_layout() {
    echo "$1" > "$STATE_FILE"
}

# Función para notificar a Waybar
update_waybar() {
    pkill -SIGRTMIN+1 waybar
}

# Si no existe el archivo, detectar layout actual del sistema
if [[ ! -f "$STATE_FILE" ]]; then
    system_layout=$(get_system_layout)
    if [[ "$system_layout" == "Spanish" || "$system_layout" == "es" ]]; then
        save_layout "es"
        current="es"
    else
        save_layout "us"
        current="us"
    fi
else
    current=$(cat "$STATE_FILE")
fi

# Alternar layout
if [[ "$current" == "us" ]]; then
    new_layout="es"
    hyprctl keyword input:kb_layout es
    notify-send "⌨ Teclado" "Cambiado a ES" -t 1000
else
    new_layout="us"
    hyprctl keyword input:kb_layout us
    notify-send "⌨ Teclado" "Cambiado a US" -t 1000
fi

# Guardar nuevo estado
save_layout "$new_layout"

# Actualizar Waybar
update_waybar