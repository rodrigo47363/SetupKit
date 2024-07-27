#!/usr/bin/python3
# coding: utf-8

# Definición de variables
SCRIPT_AUTHOR = "Rodrigo47363"
SCRIPT_URL = "https://github.com/rodrigo47363"

import re
import sys
import subprocess

def print_usage(script_name):
    """
    Imprime el uso correcto del script.

    Args:
        script_name (str): El nombre del script.
    """
    print(f"\n[!] Uso: python3 {script_name} <direccion-ip>")
    print(f"[!] Autor: {SCRIPT_AUTHOR}")
    print(f"[!] Más información: {SCRIPT_URL}\n")

def is_valid_ip(ip_address):
    """
    Valida que la dirección IP tenga el formato correcto.

    Args:
        ip_address (str): La dirección IP a validar.

    Returns:
        bool: True si la dirección IP es válida, False en caso contrario.
    """
    ip_pattern = re.compile(r"^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$")
    return ip_pattern.match(ip_address) is not None

def get_ttl(ip_address):
    """
    Obtiene el valor TTL de la dirección IP proporcionada.

    Args:
        ip_address (str): La dirección IP para realizar el ping.

    Returns:
        str: El valor TTL extraído de la respuesta del ping.
    
    Raises:
        SystemExit: Si hay un error al ejecutar el ping o extraer el TTL.
    """
    try:
        # Ejecutar el comando ping
        proc = subprocess.Popen(["ping", "-c", "1", ip_address], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        out, err = proc.communicate()

        if proc.returncode != 0:
            print(f"\n[!] Error ejecutando ping: {err.decode('utf-8')}")
            sys.exit(1)

        # Buscar el valor TTL en la salida del ping
        ttl_match = re.search(r"ttl=(\d{1,3})", out.decode('utf-8'))
        if ttl_match:
            ttl_value = ttl_match.group(1)
        else:
            print("\n[!] No se pudo encontrar el valor TTL en la respuesta del ping.")
            sys.exit(1)

        return ttl_value
    except Exception as e:
        print(f"\n[!] Error: {e}")
        sys.exit(1)

def get_os(ttl):
    """
    Determina el sistema operativo probable basado en el valor TTL.

    Args:
        ttl (str): El valor TTL extraído.

    Returns:
        str: El nombre del sistema operativo probable.
    """
    ttl = int(ttl)

    if 0 <= ttl <= 64:
        return "Linux/Unix"
    elif 65 <= ttl <= 128:
        return "Windows"
    else:
        return "No Determinado"

if __name__ == '__main__':
    # Verificación del número de argumentos
    if len(sys.argv) != 2:
        print_usage(sys.argv[0])
        sys.exit(1)

    ip_address = sys.argv[1]

    # Validación de la dirección IP
    if not is_valid_ip(ip_address):
        print("\n[!] Dirección IP no válida.\n")
        print_usage(sys.argv[0])
        sys.exit(1)

    # Obtención del valor TTL
    ttl = get_ttl(ip_address)

    # Determinación del sistema operativo
    os_name = get_os(ttl)
    
    # Impresión del resultado
    print(f"\n\t{ip_address} (ttl -> {ttl}): {os_name}")
