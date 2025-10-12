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

##### Instaldor de firefox

```bash
sudo pacman -S firefox
```

##### Instaldor de yay

```bash
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
```

##### Audio

```bash
sudo pacman -S pavucontrol
```

##### Brillo de la pantalla

```bash
sudo pacman -S brightnessctl
```

##### Capture de pantalla

```bash
sudo pacman -S hyprshot
```

##### Seleccion de color

```bash
sudo pacman -S hyprpicker
```

##### Instalar rust

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

##### Instalar alacritty

```bash
cargo install alacritty
```

##### [Nerd Font](https://www.nerdfonts.com/cheat-sheet)

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
