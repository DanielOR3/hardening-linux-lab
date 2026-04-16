
#!/bin/bash
# =================================================================
# Script de Hardening - Ubuntu  Server 22.04
# Autor: Daniel Orrala
# Fecha: abril-2026
# =================================================================

echo "[*] Iniciando hardening del sistema..."

# 1. Deshabilitar protocolos innecesarios

echo "[*] Deshabilitando protocolos  de red innecesarios..."
cat >> /etc/modprobe.d/blacklist-protocols.conf << EOF
install dcp /bin/false
install sctp /bin/false
install rds /bin/false
install tipc /bin/false
EOF

# 2. Configurar umask estricto

echo "[*] Configurando umask..."
sed -i 's/UMASK\s*022/UMASK 027/' /etc/login.defs

# 3. Configurar caducidad de contrasenas

echo "[*] COnfigurando caducidad de contrasenas..."
sed -i 's/PASS_MAX_DAYS\s*[0-9]*/PASS_MAX_DAYS 90/' /etc/login.defs
sed -i 's/PASS_MIN_DAYS\s*[0-9]*/PASS_MIN_DAYS 7/' /etc/login.defs
sed -i 's/PASS_WARN_AGE\s*[0-9]*/PASS_WARN_AGE 14/' /etc/login.defs

#4 Deshabilitar core dumps
echo "[*] Deshabilitando core dumps..."
echo "* soft core 0" >> /etc/security/limits.conf
echo "* hard core 0" >> /etc/security/limits.conf
echo "fs.suid_dumpable = 0" >> /etc/sysctl.conf
sysctl -p

# 5. Confiurar firewall
echo "[*} Configurando firewall..."
ufw allow OpenSSH
ufw --force enable

# 6. Deshabilitar servicios innecesarios
echo "[*] Deshabilitando servicios innecesarios..."
systemctl disable --now ModemManager.service
systemctl disable --now multipathd.service

# 7. Habilitad auditd
echo "[0] Habilitando auditd..."
systemctl enable auditd
systemctl start auditd

echo "[ok] Hardening completado."
