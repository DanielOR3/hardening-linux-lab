# Hardening de servidor Linux - Proyecto de portafolio

## Descripcion
Implementacion de controles de seguridad sobre Ubuntu Server 22.04 en un entorno de laboratorio virtualziado, simulando el hardening de un servidor en una pequena empresa

## Objetivos
Demostrar capacidad para identificar vulnerabilidades de configuracion en un servidor Linux y aplicar controles de seguridad siguiendo buenas practicas.

## Entorno
- VirtualBox
- Ubuntu Server 22.04 LTS
- Lynis 3.0.9 (herramienta de auditoria)

## Controles aplicados

### SSH
-Acceso root deshabilitado
- Máximo 3 intentos de autenticación
- Tiempo de gracia reducido a 30 segundos
- TCP Forwarding deshabilitado
- Agent Forwarding deshabilitado
- Máximo 2 sesiones simultáneas
- LogLevel en VERBOSE

### Firewall
- UFW habilitado
- Únicamente puerto 22 (SSH) permitido
- Todo el tráfico restante bloqueado

### Usuarios y contraseñas
- Política de contraseñas: mínimo 12 caracteres, 3 tipos de caracteres
- Bloqueo de cuenta tras 5 intentos fallidos
- Caducidad de contraseñas cada 90 días
- Umask configurado en 027

### Kernel y sistema
- Core dumps deshabilitados
- Protocolos innecesarios bloqueados: dccp, sctp, rds, tipc
- Servicios innecesarios deshabilitados: ModemManager, multipathd

### Auditoría
- auditd habilitado
- Monitoreo de archivos críticos: /etc/passwd, /etc/shadow, /etc/sudoers
- Banner legal configurado en /etc/issue y /etc/issue.net

## Resultados

| Métrica | Antes | Después |
|---|---|---|
| Lynis Hardening Index | 62 | 73 |
| Mejora | | +11 puntos |

## Herramientas utilizadas
- Lynis — auditoría y scoring de seguridad
- UFW — firewall
- auditd — auditoría de eventos del sistema
- libpam-pwquality — política de contraseñas
- pam_faillock — bloqueo de cuentas

