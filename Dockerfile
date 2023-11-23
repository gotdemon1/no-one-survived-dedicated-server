FROM cm2network/steamcmd:root

# Install wine & winetricks 
ARG WINE_BRANCH="stable"
RUN apt-get update && apt-get install -y gnupg wget xvfb \
	&& wget -nv -O- https://dl.winehq.org/wine-builds/winehq.key | APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 apt-key add - \
    && echo "deb https://dl.winehq.org/wine-builds/debian/ $(grep VERSION_CODENAME= /etc/os-release | cut -d= -f2) main" >> /etc/apt/sources.list \
    && dpkg --add-architecture i386 \
    && apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y --install-recommends winehq-${WINE_BRANCH} \
    && rm -rf /var/lib/apt/lists/* 
    
RUN wget -nv -O /usr/bin/winetricks https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks \
    && chmod +x /usr/bin/winetricks
#RUN ../steamcmd/steamcmd.sh +force_install_dir ${APPDIR} +login anonymous +app_update 1420710 validate +quit 
#RUN chown -R steam:steam ${APPDIR}

RUN  apt-get update && apt-get install -y cron systemd cabextract\
    && rm -rf /var/lib/apt/lists/* 


RUN touch /etc/cron.d/crontab
RUN chmod 0600 /etc/cron.d/crontab
RUN touch /var/log/cron.log
ENV WINEARCH="win64"
RUN winecfg
USER ${USER}

#RUN winetrick -q allfonts
##RUN winetricks -q d3dcompiler_43 d3dcompiler_47 
RUN winetricks -q d3dx11_43   
#RUN  winetricks dlls list
#RUN  wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks && bash winetricks vcrun2015
##RUN winetricks -q vcrun2013 
#RUN winetricks -q fonts list 
##RUN winetricks -q allfonts


USER root
ENV APPDIR "${HOMEDIR}/nos"
WORKDIR ${APPDIR}
ADD start.sh /etc/entrypoint.sh
ENTRYPOINT ["/etc/entrypoint.sh"]

