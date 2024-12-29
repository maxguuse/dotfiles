mkdir -p /tmp/kitty-sockets

hash=$(openssl rand -hex 16)

kitty --listen-on unix:/tmp/kitty-sockets/$hash
