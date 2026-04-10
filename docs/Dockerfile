FROM  artifactory.apps.devops.aws.bancsabadell.com/docker-virtual/crossapps/cds_devstation:6.0.0

###CDS
##NETI
##proyectos Idea
###CDSWS

USER root

###entrypoint
RUN mkdir -p /home/utibco/scripts
COPY ./sh/entrypoint.sh /home/utibco/scripts/entrypoint.sh

# 1. ELIMINAR SALTOS DE LÍNEA DE WINDOWS (CRLF a LF) AUTOMÁTICAMENTE
# Esto previene el error "$'\r': command not found" sin importar cómo guardes el archivo
RUN sed -i 's/\r$//' /home/utibco/scripts/entrypoint.sh

# 2. CREAR EL ARCHIVO DE INICIO DEL ESCRITORIO (xstartup)
# Como quitamos "startxfce4" del entrypoint, VNC necesita este archivo para saber qué dibujar
RUN mkdir -p /home/utibco/.vnc && \
    echo '#!/bin/sh' > /home/utibco/.vnc/xstartup && \
    echo 'xrdb $HOME/.Xresources' >> /home/utibco/.vnc/xstartup && \
    echo 'xsetroot -solid grey' >> /home/utibco/.vnc/xstartup && \
    echo 'export XKL_XMODMAP_DISABLE=1' >> /home/utibco/.vnc/xstartup && \
    echo 'startxfce4 &' >> /home/utibco/.vnc/xstartup

# 3. PERMISOS Y PROPIETARIO
# Nos aseguramos de que "utibco" sea dueño de sus scripts y de la carpeta oculta .vnc
RUN chown -R utibco:utibco /home/utibco/scripts /home/utibco/.vnc
RUN chmod +x /home/utibco/scripts/entrypoint.sh /home/utibco/.vnc/xstartup

USER utibco
WORKDIR /home/utibco

# 4. USAR BASH EN LUGAR DE SH
# Cambiamos /bin/sh por /bin/bash porque tu script usa sintaxis exclusiva de bash (como ${DISPLAY:1})
ENTRYPOINT ["/bin/bash", "/home/utibco/scripts/entrypoint.sh"]
CMD ["--tail-log"]
