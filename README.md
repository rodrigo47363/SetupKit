# README para `SetupKit.sh`

`SetupKit.sh` es un script de automatización diseñado para configurar y personalizar el entorno de desarrollo en sistemas Linux . Instala y configura Oh-My-Zsh, Oh-My-Bash, Powerlevel10k y fuentes Nerd Fonts para los usuarios especificados (incluyendo `root` y el usuario actual).

## Tabla de Contenidos

1. [Descripción](#descripción)
2. [Requisitos](#requisitos)
3. [Instalación](#instalación)
4. [Uso](#uso)
5. [Configuración](#configuración)
6. [Contribuciones](#contribuciones)
7. [Licencia](#licencia)

## Descripción

`SetupKit.sh` automatiza la configuración de un entorno de desarrollo avanzado al:

- Instalar dependencias básicas y paquetes necesarios.
- Configurar y personalizar Zsh y Bash con Oh-My-Zsh y Oh-My-Bash.
- Instalar el tema Powerlevel10k para Zsh.
- Descargar e instalar fuentes Hack Nerd Fonts.
- Configurar Zsh y Bash con los ajustes deseados.

## Requisitos

- **Sistemas Operativos Compatibles**: Linux (Debian/Ubuntu, RedHat/CentOS, Arch, SuSE, Alpine) y macOS.
- **Dependencias**: `curl`, `wget`, `unzip`, `git`, `zsh`, `bash`, entre otros.

## Instalación

Para instalar y configurar el entorno, sigue estos pasos:

1. **Clona el repositorio** (si aún no lo has hecho):

    ```bash
    git clone https://github.com/rodrigo47363/SetupKit.git
    cd SetupKit
    ```

2. **Da permisos de ejecución al script**:

    ```bash
    chmod +x SetupKit.sh
    ```

## Uso

Ejecuta el script con privilegios de superusuario para configurar tanto al usuario `root` como al usuario actual:

```bash
sudo ./SetupKit.sh
```

El script realiza las siguientes acciones:

1. **Instalación de dependencias básicas**: `nmap`, `nikto`, entre otros.
2. **Instalación de paquetes necesarios**: Incluye herramientas de desarrollo, utilidades de sistema, y herramientas de hacking.
3. **Instalación de Oh-My-Zsh y Oh-My-Bash**: Configura estos gestores de configuración para Zsh y Bash.
4. **Instalación de Powerlevel10k**: Tema avanzado para Oh-My-Zsh.
5. **Instalación de fuentes Nerd Fonts**: Fuentes personalizadas para terminales.

## Configuración

El script realiza las siguientes configuraciones:

- **Para Zsh**:
  - Cambia el tema a `powerlevel10k`.
  - Habilita plugins útiles como `zsh-syntax-highlighting` y `zsh-autosuggestions`.

- **Para Bash**:
  - Instala y configura Oh-My-Bash.

- **Fuentes**:
  - Instala fuentes Hack Nerd Fonts para una mejor apariencia en la terminal.

## Contribuciones

Si deseas contribuir a este proyecto, por favor sigue estos pasos:

1. **Fork** el repositorio.
2. **Crea** una nueva rama (`git checkout -b feature/nueva-funcionalidad`).
3. **Haz** tus cambios y confirma (`git commit -am 'Añadida nueva funcionalidad'`).
4. **Empuja** la rama (`git push origin feature/nueva-funcionalidad`).
5. **Abre** un Pull Request.

## Licencia

Este proyecto está licenciado bajo la [Licencia MIT](LICENSE).
