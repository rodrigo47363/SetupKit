#!/bin/bash

# Función para mostrar mensajes de error y salir
error_exit() {
    echo "Error: $1" >&2
    exit 1
}

# Función para instalar paquetes necesarios
install_packages() {
    echo "Instalando paquetes necesarios..."
    # Actualizar e instalar paquetes esenciales
    sudo apt update && sudo apt install -y git curl zsh wget unzip || error_exit "No se pudieron instalar los paquetes necesarios"
}

# Función para instalar Oh-My-Zsh
install_oh_my_zsh() {
    echo "Instalando Oh-My-Zsh..."
    # Instalar Oh-My-Zsh a través de su script de instalación
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || error_exit "No se pudo instalar Oh-My-Zsh"
}

# Función para instalar Powerlevel10k
install_powerlevel10k() {
    echo "Instalando Powerlevel10k..."
    # Clonar el repositorio de Powerlevel10k en el directorio de temas de Oh-My-Zsh
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k || error_exit "No se pudo instalar Powerlevel10k"
}

# Función para descargar e instalar fuentes Hack Nerd Fonts
install_nerd_fonts() {
    echo "Descargando e instalando fuentes Hack Nerd Fonts..."
    # Descargar fuentes Hack Nerd Fonts y moverlas a la carpeta de fuentes
    mkdir -p ~/.local/share/fonts || error_exit "No se pudo crear el directorio de fuentes"
    wget -O /tmp/hack.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip || error_exit "No se pudo descargar el archivo de fuentes"
    unzip /tmp/hack.zip -d ~/.local/share/fonts/ || error_exit "No se pudo descomprimir el archivo de fuentes"
    rm /tmp/hack.zip || error_exit "No se pudo eliminar el archivo temporal"
}

# Función para configurar Zsh y Oh-My-Zsh
configure_zsh() {
    echo "Configurando Zsh y Oh-My-Zsh..."
    # Configurar el tema y los plugins de Oh-My-Zsh en el archivo de configuración
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc || error_exit "No se pudo configurar el tema de Oh-My-Zsh"
    sed -i 's/plugins=(git)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/g' ~/.zshrc || error_exit "No se pudo configurar los plugins de Oh-My-Zsh"
}

# Función para cambiar la shell por defecto a Zsh
change_default_shell() {
    echo "Cambiando la shell por defecto a Zsh..."
    # Cambiar la shell por defecto a Zsh
    chsh -s $(which zsh) || error_exit "No se pudo cambiar la shell por defecto a Zsh"
}

# Instalación y configuración
echo "Bienvenido a la automatización de personalización del entorno."

install_packages
install_oh_my_zsh
install_powerlevel10k
install_nerd_fonts
configure_zsh
change_default_shell

echo "¡La personalización de tu entorno ha sido completada con éxito!"
