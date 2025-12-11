#!/usr/bin/env bash

ips="$(cat ~/a54/ip.txt)"

# i=$(( $RANDOM % 256 + 1 ))

# ips="$(curl --no-progress-meter https://raw.githubusercontent.com/sudo-gera/a54/refs/heads/main/ip${i}.txt)"

ip="$(
    for ip in $ips
    do
        (
            ssh -p 2222 \
                -oStrictHostKeyChecking=yes \
                -oUserKnownHostsFile="$HOME/.ssh/known_hosts" \
                -oHostKeyAlias=a54 \
                -T \
                -oClearAllForwardings=yes \
                $ip echo $ip 2>/dev/null &
        )
    done | head -n 1
)"

ssh -W 127.0.0.1:2222 -p 2222 -oHostKeyAlias=a54 "$ip"
