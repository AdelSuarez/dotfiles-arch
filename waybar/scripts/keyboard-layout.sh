#!/bin/bash

STATE_FILE="$HOME/.config/hypr/current-kb-layout"

# Si no existe el archivo, crear con valor por defecto ES
if [[ ! -f "$STATE_FILE" ]]; then
    echo "es" > "$STATE_FILE"
fi

# Leer layout actual
layout=$(cat "$STATE_FILE")

# Emitir en formato JSON para Waybar
case "$layout" in
    "us")
        echo '{"text":"US","class":"us"}'
        ;;
    "es")
        echo '{"text":"ES","class":"es"}'
        ;;
    *)
        echo '{"text":"??","class":"unknown"}'
        ;;
esac