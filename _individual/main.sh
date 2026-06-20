#!/bin/sh

if [ ! -f /etc/wireguard/wg0.conf ]; then
    echo
    echo "Adding the default config..."
    echo

    cp /tmp/default.conf /etc/wireguard/wg0.conf

    sed -i "s|PrivateKey =|PrivateKey = $(wg genkey)|" /etc/wireguard/wg0.conf

    echo
    echo "Default config added:"
    cat /etc/wireguard/wg0.conf
    echo
fi

mkdir -p /wgd/run/log
exec ./wgd.sh start
