<<<<<<< HEAD
# jiap-nagios
Evaluación sumativa 2
=======
#Contenedor nagios

Descarga y compilacion de imagen de Nagios.

#Descarga:
```
git clone https://github.com/Joaquin-ArevaloDuoc/jiap-nagios
```
#Cambio de directorio:
```
cd jiap-nagios
```
#Ejecucion de build Nagios:
```
docker build -t nagios .
```
#Ejecucion de Imagen Nagios:
```
docker run -it -d -p 80:80 nagios
```
#Acceso a Nagios: 
```
http://<direccion_ip>/nagios
```
#Credenciales nagios
```
usuario: nagiosadminJIAP
contraseña: Duoc.2024
```
>>>>>>> 98065aa (Primer Commit)
