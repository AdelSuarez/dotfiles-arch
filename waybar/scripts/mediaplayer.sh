# #!/bin/bash

# # Desactivar completamente el buffering para salida inmediata
# exec stdbuf -o0 bash -c '
# last_output=""

# while true; do
#     # Verificar Spotify de manera robusta
#     if playerctl -p spotify status >/dev/null 2>&1; then
#         title=$(playerctl -p spotify metadata title 2>/dev/null)
#         artist=$(playerctl -p spotify metadata artist 2>/dev/null) 
#         status=$(playerctl -p spotify status 2>/dev/null)
        
#         if [[ -n "$title" ]]; then
#             # Formatear texto
#             if [[ -n "$artist" ]]; then
#                 text="$artist - $title"
#             else
#                 text="$title"
#             fi
            
#             # Acortar si es muy largo
#             if [[ ${#text} -gt 35 ]]; then
#                 text="${text:0:32}..."
#             fi
            
#             # Agregar icono según estado
#             if [[ "$status" == "Paused" ]]; then
#                 current_output="{\"text\": \" $text \", \"class\": \"custom-media\"}"
#             else
#                 current_output="{\"text\": \" $text \", \"class\": \"custom-media\"}"
#             fi
#         else
#             current_output="{\"text\": \"\", \"class\": \"custom-media\"}"
#         fi
#     else
#         current_output="{\"text\": \"\", \"class\": \"custom-media\"}"
#     fi
    
#     # Imprimir SOLO si cambió y forzar salida inmediata
#     if [[ "$current_output" != "$last_output" ]]; then
#         echo "$current_output"
#         # Forzar flush inmediato
#         sleep 0.001
#         last_output="$current_output"
#     fi
    
#     sleep 1
# done
# '

#!/bin/bash

# Desactivar buffering
exec stdbuf -o0 bash -c '
spotify_running=false
last_output="null"  # Inicializar con algo diferente

while true; do
    # Verificar si Spotify está corriendo
    if ! pgrep -x "spotify" > /dev/null 2>&1; then
        if [[ "$spotify_running" == true ]]; then
            # Spotify se cerró
            echo "{\"text\": \"\", \"class\": \"custom-media\"}"
            spotify_running=false
            last_output="null"
        fi
        sleep 2
        continue
    fi
    
    # Spotify está corriendo
    spotify_running=true
    
    # Obtener información
    status=$(playerctl -p spotify status 2>/dev/null || echo "Stopped")
    title=$(playerctl -p spotify metadata title 2>/dev/null || echo "")
    artist=$(playerctl -p spotify metadata artist 2>/dev/null || echo "")
    
    current_output=""
    
    if [[ -n "$title" && "$title" != "" ]]; then
        # Formatear texto
        if [[ -n "$artist" && "$artist" != "" ]]; then
            text="$artist - $title"
        else
            text="$title"
        fi
        
        # Acortar si es muy largo
        if [[ ${#text} -gt 35 ]]; then
            text="${text:0:32}..."
        fi
        
        # Agregar icono según estado
        if [[ "$status" == "Paused" ]]; then
            current_output="{\"text\": \" $text \", \"class\": \"custom-media\"}"
        elif [[ "$status" == "Playing" ]]; then
            current_output="{\"text\": \" $text \", \"class\": \"custom-media\"}"
        else
            current_output="{\"text\": \"\", \"class\": \"custom-media\"}"
        fi
    else
        # Spotify está abierto pero no reproduce nada
        current_output="{\"text\": \"\", \"class\": \"custom-media\"}"
    fi
    
    # Imprimir SOLO si cambió
    if [[ "$current_output" != "$last_output" ]]; then
        echo "$current_output"
        last_output="$current_output"
    fi
    
    sleep 1
done
'