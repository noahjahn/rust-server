FROM cm2network/steamcmd

USER root

RUN apt update -y && apt install -y libsqlite3-dev

USER steam

ENV SERVER_PORT=28015
ENV SERVER_LEVEL="Procedural Map"
ENV SERVER_SEED=1234
ENV SERVER_WORLDSIZE=4000
ENV SERVER_MAXPLAYERS=10
ENV SERVER_HOSTNAME="Tom Server"
ENV SERVER_DESCRIPTION="Awesome!"
ENV SERVER_URL="http://mysite.com"
ENV SERVER_HEADERIMAGE="http://mysite.com/serverimage.jpg"
ENV SERVER_IDENTITY="server1"
ENV RCON_PORT=28016
ENV RCON_PASSWORD="letmein"
ENV RCON_WEB=1
ENV LOGFILE="2>&1"
ENV SERVER_PATH="/home/steam/rust"
ENV LD_LIBRARY_PATH="./RustDedicated_Data/Plugins/x86_64"

RUN ./steamcmd.sh +login anonymous +force_install_dir $SERVER_PATH +app_update 258550 validate +quit

COPY --chown=steam:steam bin/run.sh /home/steam/rust

WORKDIR /home/steam/rust

CMD [ "/bin/bash", "./run.sh" ]
