# Configuración del entorno Arch

## Hyprland y wayland

Los archivos ya contiene las configuraciones correspondientes, a continuación se encontraran las instalaciones de paquetes necesarios y uso de los atajos de teclado.

> [!NOTE]
> Verificar si los archivos de las carpetas scripts, tienen permiso de ejecución, si no los tiene hacerlo con el comando.
>
> ```bash
> chmod +x nombre_archivo
> ```

![](/assets/cap1.png)

#### Instaldor de firefox

```bash
sudo pacman -S firefox
```

#### Git

Gestor de versiones

```bash
sudo pacman -S git
```

#### Instaldor de yay

Gestor de paquetes de aur.

```bash
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
```

#### Audio

Controlador de audio.

```bash
sudo pacman -S pavucontrol
```

#### Brillo de la pantalla

Controlador del brillo de la pantalla con las teclas especiales.

```bash
sudo pacman -S brightnessctl
```

En la configuracion de hypr se coloca esto:

```bash
bindel = ,XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+
bindel = ,XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-
```

#### Capture de pantalla

Controlador para secar captures de pantalla, tanto pantalla completa como partes seleccionadas.

```bash
sudo pacman -S hyprshot
```

En la configuracion de hypr se coloca esto:

```bash
bind = , PRINT, exec, mkdir -p ~/Images/Cap &&  hyprshot -m output -o ~/Images/Cap
bind =  SHIFT, PRINT, exec, mkdir -p ~/Images/Cap && hyprshot -m region -o ~/Images/Cap
```

#### Luz azul de pantalla

Paquete para la luz azul va ligado a configuracion de hyprsunset.conf

```bash
sudo pacman -S hyprsunset
```

#### Seleccion de color

Controlador para obtener el color seleccionado por el cursor.

```bash
sudo pacman -S hyprpicker
```

En la configuracion de hypr se coloca esto:

```bash
bind = SUPER, C, exec, hyprpicker -a
# Color picker - formato RGB
bind = SUPER CTRL, C, exec, hyprpicker -a -f rgb
# Color picker - formato HEX en mayúsculas
bind = SUPER ALT, C, exec, hyprpicker -a -f hex
```

#### Display manager

Administador de ventanas y login del sistema.

```bash
sudo pacman -S sddm
```

#### Thunar

Explorador de archivos.

```bash
sudo pacman -S thunar
```

#### Rofi

Gestor de vista de aplicacion.

```bash
sudo pacman -S rofi
```

#### Visual studio code

Editor de codigo.

```bash
sudo yay -S visual-studio-code-bin
```

#### Fuentes

Fuentes de texto que contienen emojis.

```bash
sudo pacman -S noto-fonts
sudo pacman -S noto-fonts-cjk
sudo pacman -S noto-fonts-emoji
sudo pacman -S noto-fonts-extra
```

#### Fastfetch

Para mostrar la informacion del sistema en la terminal.

```bash
sudo pacman -S fastfetch
```

#### Spotify

Se instala desde la pqueteria de aur.

```bash
sudo yay -S spotify
```

#### 7z

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

#### Instalar rust

Instalacion desde la pagina principal.

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Intalacion desde los paquetes de arch.

```bash
sudo pacman -S rust
```

#### Instalar alacritty

Instalacion desde la cargo.

```bash
cargo install alacritty
```

Instalacion desde los paquetes de arch.

```bash
sudo pacman -S alacritty
```

#### [Nerd Font](https://www.nerdfonts.com/cheat-sheet)

Glifos de fuentes de iconos

```
https://www.nerdfonts.com/cheat-sheet
```

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
| **mod + m**                  | cerrar sesion                                     |
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

| Atajo             | Acción                        |
| ----------------- | ----------------------------- |
| **print**         | capture completo de pantalla  |
| **shift + print** | capture del area seleccionada |

#### Selector de color

| Atajo              | Acción                             |
| ------------------ | ---------------------------------- |
| **mod + c**        | selecciona el color en formato RGB |
| **mod + ctrl + c** | selecciona el color en formato hex |
