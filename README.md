# Configuración del entorno Arch

## Hyprland y waybar.

Los archivos ya contienen las configuraciones correspondientes, a continuación se encontraran las instalaciones de paquetes necesarios y uso de los atajos de teclado.

> [!NOTE]
> Verificar si los archivos de las carpetas scripts, tienen permiso de ejecución, si no los tiene hacerlo con el comando.
>
> ```bash
> chmod +x nombre_archivo
> ```

![](/assets/cap1.png)

### firefox

```bash
sudo pacman -S firefox
```

### Git

Gestor de versiones

```bash
sudo pacman -S git
```

### Instalador de yay

Gestor de paquetes de aur.

```bash
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
```

### Audio

Controlador de audio.

```bash
sudo pacman -S pavucontrol
```

### Brillo de la pantalla

Controlador del brillo de la pantalla con las teclas especiales.

```bash
sudo pacman -S brightnessctl
```

En la configuracion de hypr se coloca esto:

```bash
bindel = ,XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+
bindel = ,XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-
```

### Capture de pantalla

Controlador para capturas de pantalla, tanto pantalla completa como partes seleccionadas.

```bash
sudo pacman -S hyprshot
```

En la configuración de hypr se coloca esto:

```bash
bind = , PRINT, exec, mkdir -p ~/Images/Cap &&  hyprshot -m output -o ~/Images/Cap
bind =  SHIFT, PRINT, exec, mkdir -p ~/Images/Cap && hyprshot -m region -o ~/Images/Cap
```

### Luz azul de pantalla

Paquete para la luz azul, va ligado a configuración de hyprsunset.conf

```bash
sudo pacman -S hyprsunset
```

### Selección de color

Controlador para obtener el color seleccionado por el cursor.

```bash
sudo pacman -S hyprpicker
```

En la configuración de hypr se coloca esto:

```bash
bind = SUPER, C, exec, hyprpicker -a
# Color picker - formato RGB
bind = SUPER CTRL, C, exec, hyprpicker -a -f rgb
# Color picker - formato HEX en mayúsculas
bind = SUPER ALT, C, exec, hyprpicker -a -f hex
```

### Display manager

Administador de ventanas y login del sistema.

```bash
sudo pacman -S sddm
```

### Nemo

Explorador de archivos.

```bash
sudo pacman -S nemo
```

#### Extensión nemo-fileroller

Es una extensión del administrador de archivos de Nemo que permite crear y extraer archivos comprimidos (como .zip, .tar.gz, etc.) directamente desde el menú contextual del clic derecho.

```bash
sudo pacman -S nemo-fileroller
```

### Rofi

Gestor de lanzador de aplicaciones.

```bash
sudo pacman -S rofi
```

### Visual studio code

Editor de código.

```bash
yay -S visual-studio-code-bin
```

### Fuentes

Fuentes de texto que contienen emojis.

```bash
sudo pacman -S noto-fonts
sudo pacman -S noto-fonts-cjk
sudo pacman -S noto-fonts-emoji
sudo pacman -S noto-fonts-extra
sudo pacman -S otf-font-awesome
sudo pacman -S ttf-fira-code
sudo pacman -S ttf-hack
sudo pacman -S ttf-hack-nerd
sudo pacman -S ttf-inconsolata
sudo pacman -S ttf-jetbrains-mono
sudo pacman -S ttf-meslo-nerd
sudo pacman -S ttf-nerd-fonts-symbols
sudo pacman -S woff2-font-awesome
```

### Portapapeles

```bash
sudo pacman -S wl-clipboard
```

### blueman manager

Administrador de Bluetooth.

```bash
sudo pacman -S blueman
```

### Fastfetch

Para mostrar la información del sistema en la terminal.

```bash
sudo pacman -S fastfetch
```

### Spotify

Se instala desde la paqueteria de aur.

```bash
yay -S spotify
```

##### Módulo de spotify para waybar

Se debe crear un script que puede tener como nombre "mediaplayer.sh" en el directorio de waybar, el cual debe contener lo siguiente:

```bash
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
```

Luego el .sh se le debe dar permisos de ejecución:

```bash
chmod +x mediaplayer.sh
```

luego en el config.jsonc del directorio de waybar se coloca lo siguiente:

```bash
  "custom/media": {
    "exec": "~/.config/waybar/scripts/mediaplayer.sh",
    "format": "{}",
    "return-type": "json",
    "max-length": 40,
    "restart-interval": 5,
    "on-click": "playerctl -p spotify play-pause",
    "on-scroll-up": "playerctl -p spotify next",
    "on-scroll-down": "playerctl -p spotify previous"
  },
```

y se indica en que parte de la barra de waybar va a ir:

```bash
  "modules-left": [
    "custom/media"
  ],
```

![](/assets/cap2.png)

### Daemon para perfiles de poder

Gestiona los perfiles de poder del procesador.

```bash
sudo pacman -S power-profiles-daemon
```

### 7z

Gestor de archivos comprimidos

```bash
sudo pacman -S 7zip
```

Comandos principales:

```bash
#Comprimir archivo
7z a mi_archivo.7z /ruta/a/mi/archivo
#Descomprimir archivo
7z x mi_archivo.7z
```

### Instalar rust

Instalación desde la página principal.

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Instalación desde los paquetes de arch.

```bash
sudo pacman -S rust
```

### Instalar alacritty

Instalación desde la cargo.

```bash
cargo install alacritty
```

Instalación desde los paquetes de arch.

```bash
sudo pacman -S alacritty
```

#### [Nerd Font](https://www.nerdfonts.com/cheat-sheet)

Glifos de fuentes de iconos

```
https://www.nerdfonts.com/cheat-sheet
```

### Módulo de distribución de teclado (US - ES)

Módulo diseñado para cambiar la distribución del teclado, el cual va ligado con hyprland y waybar, primero se crea un script que puede tener como nombre "keyboard-layout.sh" el cual debe contener:

```bash
#!/bin/bash
# Verifica en hypr la ultima distribución seleccionada
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
```

luego se le da permisos de ejecución:

```bash
chmod +x keyboard-layout.sh
```

luego en el config.jsonc del directorio waybar se coloca lo siguiente:

```bash
  "custom/keyboard-layout": {
    "exec": "~/.config/waybar/scripts/keyboard-layout.sh",
    "return-type": "json",
    "format": "⌨ {text}",
    "on-click": "~/.config/hypr/scripts/switch-kb-layout.sh",
    "interval": 2,
    "restart-interval": 1
  },
```

y se indica en que parte de la barra de waybar va a ir:

```bash
  "modules-right": [
    "mpd",
    "pulseaudio",
    "network",
    "cpu",
    "memory",
    "temperature",
    "backlight",
    "power-profiles-daemon",
    "battery",
    "custom/keyboard-layout", // <-----------
    "clock",
    "tray"
  ],
```

continuamos con la configuración de hyprland, en el directorio de hypr, se crean los siguientes scripts, el primero puede tener como nombre "init-kb-layout.sh" y debe contener:

```bash
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
```

el segundo puede tener como nombre "switch-kb-layout.sh" y debe contener:

```bash
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
```

ambos scripts deben tener permisos de ejecución:

```bash
chmod +x init-kb-layout.sh
chmod +x switch-kb-layout.sh
```

por ultimo, en el archivo hyprland.config se coloca:

```bash
exec-once = ~/.config/hypr/scripts/init-kb-layout.sh
```

y el bind del teclado es:

```bash
bind = $mainMod, Space, exec, ~/.config/hypr/scripts/switch-kb-layout.sh
```

![](/assets/cap3.png)

# Configuración de teclas (hypr)

| Atajo                        | Acción                                            |
| ---------------------------- | ------------------------------------------------- |
| **mod + enter**              | abrir terminal                                    |
| **mod + r**                  | abrir rofi                                        |
| **mod + f**                  | abrir navegador                                   |
| **mod + shift + f**          | abrir navegador incógnito                         |
| **mod + e**                  | abrir explirador de archivos                      |
| **mod + w**                  | cerrar ventana                                    |
| **mod + [12345678]**         | ir al espacio de trabajo [12345678]               |
| **mod + shift + [12345678]** | mueve la ventana al espacio de trabajo [12345678] |
| **mod + m**                  | cerrar sesión                                     |
| **mod + space**              | cambio de distribución de teclado (us/es)         |

#### Para gestos de ventanas

| Atajo               | Acción                                 |
| ------------------- | -------------------------------------- |
| **mod + h**         | mover a la izquierda                   |
| **mod + j**         | mover hacia abajo                      |
| **mod + k**         | mover hacia arriba                     |
| **mod + l**         | mover a la derecha                     |
| **mod + ctrl + h**  | mover ventana a la izquierda           |
| **mod + ctrl + j**  | mover ventana hacia abajo              |
| **mod + ctrl + k**  | mover ventana hacia arriba             |
| **mod + ctrl + l**  | mover ventana a la derecha             |
| **mod + shift + h** | Redimensiona la ventana a la izquierda |
| **mod + shift + j** | Redimensiona la ventana hacia abajo    |
| **mod + shift + k** | Redimensiona la ventana hacia arriba   |
| **mod + shift + l** | Redimensiona la ventana a la derecha   |

#### Capture de pantalla

| Atajo               | Acción                        |
| ------------------- | ----------------------------- |
| **mod + p**         | capture completo de pantalla  |
| **mod + shift + p** | capture del área seleccionada |

#### Selector de color

| Atajo              | Acción                             |
| ------------------ | ---------------------------------- |
| **mod + c**        | selecciona el color en formato RGB |
| **mod + ctrl + c** | selecciona el color en formato hex |
