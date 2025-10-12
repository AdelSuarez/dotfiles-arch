# #!/bin/bash

# # Función para obtener la canción actual
# get_current_song() {
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
            
#             # Agregar icono de pausa si está pausado
#             if [[ "$status" == "Paused" ]]; then
#                 echo "{\"text\": \" $text\", \"class\": \"custom-media\"}"
#             else
#                 echo "{\"text\": \" $text\", \"class\": \"custom-media\"}"
#             fi
#         else
#             echo "{\"text\": \"\", \"class\": \"custom-media\"}"
#         fi
#     else
#         echo "{\"text\": \"\", \"class\": \"custom-media\"}"
#     fi
# }

# # Ejecutar continuamente y escuchar cambios
# while true; do
#     get_current_song
#     # Esperar a que cambie el estado de Spotify
#     playerctl -p spotify metadata --follow | head -1 >/dev/null 2>&1
#     sleep 0.5
# done

# #!/bin/bash

# last_output=""
# spotify_not_found_count=0
# max_retries=30  # Segundos antes de cerrarse (30 segundos)

# while true; do
#     # Obtener información actual
#     if playerctl -p spotify status >/dev/null 2>&1; then
#         spotify_not_found_count=0  # Resetear contador
        
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
#                 current_output="{\"text\": \" $text\", \"class\": \"custom-media\"}"
#             else
#                 current_output="{\"text\": \" $text\", \"class\": \"custom-media\"}"
#             fi
#         else
#             current_output="{\"text\": \"\", \"class\": \"custom-media\"}"
#         fi
#     else
#         current_output="{\"text\": \"\", \"class\": \"custom-media\"}"
#         ((spotify_not_found_count++))
        
#         # Si Spotify no se encuentra por mucho tiempo, salir
#         if [[ $spotify_not_found_count -ge $max_retries ]]; then
#             echo "{\"text\": \"\", \"class\": \"custom-media\"}"
#             exit 0
#         fi
#     fi
    
#     # Solo imprimir si cambió la salida
#     if [[ "$current_output" != "$last_output" ]]; then
#         echo "$current_output"
#         last_output="$current_output"
#     fi
    
#     sleep 1
# done

#!/bin/bash

# Desactivar completamente el buffering para salida inmediata
exec stdbuf -o0 bash -c '
last_output=""

while true; do
    # Verificar Spotify de manera robusta
    if playerctl -p spotify status >/dev/null 2>&1; then
        title=$(playerctl -p spotify metadata title 2>/dev/null)
        artist=$(playerctl -p spotify metadata artist 2>/dev/null) 
        status=$(playerctl -p spotify status 2>/dev/null)
        
        if [[ -n "$title" ]]; then
            # Formatear texto
            if [[ -n "$artist" ]]; then
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
                current_output="{\"text\": \" $text\", \"class\": \"custom-media\"}"
            else
                current_output="{\"text\": \" $text\", \"class\": \"custom-media\"}"
            fi
        else
            current_output="{\"text\": \"\", \"class\": \"custom-media\"}"
        fi
    else
        current_output="{\"text\": \"\", \"class\": \"custom-media\"}"
    fi
    
    # Imprimir SOLO si cambió y forzar salida inmediata
    if [[ "$current_output" != "$last_output" ]]; then
        echo "$current_output"
        # Forzar flush inmediato
        sleep 0.001
        last_output="$current_output"
    fi
    
    sleep 1
done
'
