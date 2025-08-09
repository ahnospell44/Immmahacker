#!/bin/bash
set -e

USERNAME="$(whoami)"
BASEDIR="/home/$USERNAME/RedTeamTools"

echo "[*] Setting up Red Team Tools in $BASEDIR ..."
mkdir -p "$BASEDIR/evilnginx/config" "$BASEDIR/evilnginx/phishlets"
mkdir -p "$BASEDIR/pwndrop/config"
mkdir -p "$BASEDIR/gophish/config"

# Create all-in-one docker-compose.yml
cat > "$BASEDIR/docker-compose.yml" <<'EOF'
version: "3.8"

services:
  evilnginx:
    image: warhorse/evilnginx2
    container_name: evilnginx
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./evilnginx/config:/config
      - ./evilnginx/phishlets:/phishlets
    restart: unless-stopped

  pwndrop:
    image: linuxserver/pwndrop
    container_name: pwndrop
    ports:
      - "8080:8080"
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=America/New_York
    volumes:
      - ./pwndrop/config:/config
    restart: unless-stopped

  gophish:
    image: gophish/gophish
    container_name: gophish
    ports:
      - "3333:3333"
      - "3380:80"
    volumes:
      - ./gophish/config:/config
    restart: unless-stopped
EOF

# Deploy all services
cd "$BASEDIR"
echo "[*] Starting all containers..."
docker compose up -d

echo "[✔] Evilnginx, Pwndrop, and GoPhish are now running."
