#!/bin/bash
set -e

USERNAME="$(whoami)"
BASEDIR="/home/$USERNAME/RedTeamTools"
PROJECTS=("evilnginx" "pwndrop" "gophish")

echo "[*] Setting up Red Team Tools deployment for user: $USERNAME"

# Create base directory
mkdir -p "$BASEDIR"

for PROJECT in "${PROJECTS[@]}"; do
    echo "[*] Preparing $PROJECT ..."
    mkdir -p "$BASEDIR/$PROJECT/config"

    # Create extra dirs where needed
    if [ "$PROJECT" == "evilnginx" ]; then
        mkdir -p "$BASEDIR/$PROJECT/phishlets"
    fi

    # Write docker-compose.yml to project folder
    case "$PROJECT" in
        evilnginx)
            cat > "$BASEDIR/$PROJECT/docker-compose.yml" <<'EOF'
version: "3.8"
services:
  evilnginx:
    image: warhorse/evilginx2
    container_name: evilnginx
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./config:/config
      - ./phishlets:/phishlets
    restart: unless-stopped
EOF
            ;;
        pwndrop)
            cat > "$BASEDIR/$PROJECT/docker-compose.yml" <<'EOF'
version: "3.8"
services:
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
      - ./config:/config
    restart: unless-stopped
EOF
            ;;
        gophish)
            cat > "$BASEDIR/$PROJECT/docker-compose.yml" <<'EOF'
version: "3.8"
services:
  gophish:
    image: gophish/gophish
    container_name: gophish
    ports:
      - "3333:3333"
      - "3380:80"
    volumes:
      - ./config:/config
    restart: unless-stopped
EOF
            ;;
    esac

    # Start project
    echo "[*] Starting $PROJECT container ..."
    (cd "$BASEDIR/$PROJECT" && docker compose up -d)
done

echo "[✔] All Red Team tools deployed successfully!"
