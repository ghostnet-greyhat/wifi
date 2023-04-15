#!/bin/bash
#create by ghostnet

# Definir las variables de la red
red="nombre-de-la-red"    # Reemplazar "nombre-de-la-red" por el nombre de tu red WiFi
clave="clave-de-seguridad"    # Reemplazar "clave-de-seguridad" por la clave de tu red WiFi

# Verificar que la tarjeta WiFi esté conectada
if ! ifconfig wlan0 &> /dev/null; then
    echo "No se ha detectado la tarjeta WiFi."
    exit 1
fi

# Conectarse a la red WiFi
echo "Conectándose a la red $red..."
if ! iwconfig wlan0 essid "$red" key s:"$clave" &> /dev/null; then
    echo "No se ha podido conectar a la red $red."
    exit 1
fi

# Obtener una dirección IP mediante DHCP
echo "Obteniendo una dirección IP..."
if ! dhclient wlan0 &> /dev/null; then
    echo "No se ha podido obtener una dirección IP."
    exit 1
fi

# Mostrar la dirección IP obtenida
ip=$(ifconfig wlan0 | awk '/inet / {print $2}')
echo "Se ha obtenido la dirección IP $ip."

