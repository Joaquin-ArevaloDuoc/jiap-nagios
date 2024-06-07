FROM debian:stable

# Entorno no interactivo
ENV DEBIAN_FRONTEND=noninteractive

# Actualiza las listas de paquetes e instala los necesarios
RUN apt-get update && \
    apt-get install -y autoconf gcc libc6 make wget unzip apache2 php libapache2-mod-php libgd-dev openssl libssl-dev libmcrypt-dev bc gawk dc build-essential snmp libnet-snmp-perl gettext && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Descarga el código fuente de Nagios Core
RUN mkdir /tmp/nagios && \
    cd /tmp/nagios && \
    wget -O nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.4.14.tar.gz && \
    tar xzf nagioscore.tar.gz

# Compila Nagios Core
RUN cd /tmp/nagios/nagioscore-nagios-4.4.14 && \
    ./configure --with-httpd-conf=/etc/apache2/sites-enabled && \
    make all && \
    make install-groups-users && \
    usermod -a -G nagios www-data && \
    make install && \
    make install-daemoninit && \
    make install-commandmode && \
    make install-config && \
    make install-webconf && \
    a2enmod rewrite && \
    a2enmod cgi

# Crea la cuenta de usuario nagiosadmin
RUN htpasswd -cb /usr/local/nagios/etc/htpasswd.users nagiosadminJIAP Duoc.2024

# Configuración del firewall
RUN apt-get update && apt-get install -y ufw \
    && ufw allow 80/tcp \
    && ufw allow 443/tcp \
    && ufw reload

# Expone el puerto 80
EXPOSE 80

# Inicia el servidor web Apache y Nagios Core
CMD service apache2 start && /usr/local/nagios/bin/nagios /usr/local/nagios/etc/nagios.cfg

