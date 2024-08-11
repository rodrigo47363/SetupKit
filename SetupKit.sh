#!/bin/bash

# Variables de información del script
SCRIPT_VERSION="1.2"
SCRIPT_AUTHOR="Rodrigo47363"
SCRIPT_URL="https://github.com/rodrigo47363"

# Colores para mensajes de salida
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
RESET="\e[0m"

# Directorio de instalación por defecto para temas personalizados de Oh-My-Zsh
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Función para mostrar mensajes de error y salir
error_exit() {
    echo -e "${RED}Error: $1${RESET}" >&2
    exit 1
}

# Función para instalar dependencias básicas
install_deps() {
    echo "Instalando dependencias..."
    case "$(uname -s)" in
        Linux)
            if [ -f /etc/debian_version ] || grep -q "Kali" /etc/os-release || grep -q "Parrot" /etc/os-release; then
                sudo apt-get update
                sudo apt-get install -y nmap nikto
            elif [ -f /etc/redhat-release ]; then
                if grep -q "CentOS Linux release 8" /etc/redhat-release; then
                    sudo dnf update
                    sudo dnf install -y nmap nikto
                else
                    sudo yum update
                    sudo yum install -y nmap nikto
                fi
            elif [ -f /etc/arch-release ]; then
                sudo pacman -Syu --noconfirm nmap nikto
            elif [ -f /etc/SuSE-release ] || [ -f /etc/SUSE-brand ] || [ -f /etc/SUSE-release ]; then
                sudo zypper refresh
                sudo zypper install -y nmap nikto
            elif [ -f /etc/alpine-release ]; then
                sudo apk update
                sudo apk add nmap nikto
            else
                echo "Error: Sistema Linux no soportado."
                exit 1
            fi
            ;;
        Darwin)
            brew update
            brew install nmap nikto
            ;;
        *)
            echo "Error: Sistema operativo no soportado. Instale manualmente nmap y nikto."
            exit 1
            ;;
    esac
    echo "Las dependencias se han instalado correctamente."
}

# Función para instalar paquetes necesarios
install_packages() {
    echo -e "${YELLOW}Instalando paquetes necesarios...${RESET}"
    sudo apt update && sudo apt install -y \
        git curl zsh wget unzip php build-essential aircrack-ng airgeddon kitty ruby rofi \
        cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev \
        libxcb-ewmh-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto \
        libxcb-image0-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev \
        libasound2-dev libpulse-dev libjsoncpp-dev libmpdclient-dev libuv1-dev libnl-genl-3-dev \
        meson picom libxext-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-render-util0-dev \
        libxcb-render0-dev libxcb-present-dev libxcb-xinerama0-dev libpixman-1-dev libdbus-1-dev \
        libconfig-dev libgl1-mesa-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev \
        libxcb-glx0-dev libpcre3 libpcre3-dev feh scrot scrub xclip bat locate ranger neofetch \
        wmname acpi bspwm sxhkd imagemagick cmatrix zsh-syntax-highlighting zsh-autosuggestions \
        hcxdumptool hcxtools lsd || error_exit "No se pudieron instalar los paquetes necesarios"
}

# Función para instalar Oh-My-Zsh
install_oh_my_zsh() {
    echo -e "${YELLOW}Instalando Oh-My-Zsh...${RESET}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || error_exit "No se pudo instalar Oh-My-Zsh"
}

# Función para instalar Powerlevel10k
install_powerlevel10k() {
    echo -e "${YELLOW}Instalando Powerlevel10k...${RESET}"
    [ ! -d "${ZSH_CUSTOM}/themes" ] && mkdir -p "${ZSH_CUSTOM}/themes"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM}/themes/powerlevel10k || error_exit "No se pudo instalar Powerlevel10k"
}

# Función para descargar e instalar fuentes Hack Nerd Fonts
install_nerd_fonts() {
    echo -e "${YELLOW}Descargando e instalando fuentes Hack Nerd Fonts...${RESET}"
    FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip"
    FONT_DIR="$HOME/.local/share/fonts"
    FONT_FILE="/tmp/hack.zip"

    wget -O "$FONT_FILE" "$FONT_URL" || error_exit "No se pudo descargar el archivo de fuentes"
    unzip "$FONT_FILE" -d "$FONT_DIR" || error_exit "No se pudo descomprimir el archivo de fuentes"
    rm "$FONT_FILE" || error_exit "No se pudo eliminar el archivo temporal"
    fc-cache -fv || error_exit "No se pudo actualizar la caché de fuentes"
}

# Función para configurar Zsh y Oh-My-Zsh
configure_zsh() {
    echo -e "${YELLOW}Configurando Zsh y Oh-My-Zsh...${RESET}"
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc || error_exit "No se pudo configurar el tema de Oh-My-Zsh"
    sed -i 's/plugins=(git)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/g' ~/.zshrc || error_exit "No se pudo configurar los plugins de Oh-My-Zsh"
}

# Función para cambiar la shell por defecto a Zsh
change_default_shell() {
    echo -e "${YELLOW}Cambiando la shell por defecto a Zsh...${RESET}"
    chsh -s $(which zsh) || error_exit "No se pudo cambiar la shell por defecto a Zsh"
}

# Mensaje de bienvenida
echo -e "${GREEN}####################################${RESET}"
echo -e "${GREEN}# SetupKit.sh v${SCRIPT_VERSION} #${RESET}"
echo -e "${GREEN}# Creado por ${SCRIPT_AUTHOR} #${RESET}"
echo -e "${GREEN}# ${SCRIPT_URL} #${RESET}"
echo -e "${GREEN}####################################${RESET}"
echo -e "${GREEN}Bienvenido a la automatización de personalización del entorno.${RESET}"

# Ejecución de funciones
install_deps
install_packages
install_oh_my_zsh
install_powerlevel10k
install_nerd_fonts
configure_zsh
change_default_shell

echo -e "${GREEN}¡La personalización de tu entorno ha sido completada con éxito!${RESET}"
