# What?
This is a Dockerfile allowing you to run the No One Survived Dedicated 
Server inside of a Docker container, through Wine.
<p >
!!
<b style="color: red;">For now, its not working fine</b>
!!
</p>
<pre>
version: "3.2"

services:
  nos:
    image: nos:latest
    build:
      context: .
      dockerfile: Dockerfile
    container_name: nos
    restart: "unless-stopped"
    volumes:
      - ./cmd:/home/steam/steamcmd
      - ./data:/home/steam/nos-dedicated
      - ./startup.sh:/root/startup.sh
    environment:
      - PUID=911
      - PGID=911
      - STEAMAPPID=2329680
      - STEAMAPPDIR=/home/steam/nos-dedicated
      - STEAMCMDDIR=/home/steam/steamcmd
      - NOS_ARGS=-USEALLAVAILABLECORES -high -preload -log -server
    ports:
      - 7767:7767/udp
      - 7768:7768/udp
      - 27014:27014/udp
      </pre>
