#!/bin/sh

# go to root
cd

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

# install wget and curl
apt-get update;apt-get -y install wget curl;

# set time GMT +7
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
service ssh restart

# set repo
curl -o /etc/apt/sources.list "https://raw.githubusercontent.com/orangbiasa/script/master/orangbiasa.debian.list"
wget "http://www.dotdeb.org/dotdeb.gpg"
cat dotdeb.gpg | apt-key add -;rm dotdeb.gpg

# remove unused
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove sendmail*;
apt-get -y --purge remove bind9*;

# update
apt-get update; apt-get -y upgrade;

# install essential package
apt-get -y install bmon iftop htop nmap axel nano iptables traceroute sysv-rc-conf dnsutils bc nethogs vnstat less screen psmisc apt-file whois ptunnel ngrep mtr git zsh unzip unrar rsyslog debsums rkhunter
apt-get -y install build-essential

# disable exim
service exim4 stop
sysv-rc-conf exim4 off

# update apt-file
apt-file update

# setting vnstat
vnstat -u -i venet0
service vnstat restart

# setting port ssh
sed -i '/Port 22/a Port 143' /etc/ssh/sshd_config
sed -i '/Port 22/a Port  80' /etc/ssh/sshd_config
sed -i 's/Port 22/Port  22/g' /etc/ssh/sshd_config
service ssh restart

# install dropbear
apt-get -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=443/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 109 -p 110"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
service ssh restart
service dropbear restart

# install fail2ban
apt-get -y install fail2ban;service fail2ban restart

# install webmin
cd
wget "http://prdownloads.sourceforge.net/webadmin/webmin_1.680_all.deb"
dpkg --install webmin_1.680_all.deb;
apt-get -y -f install;
rm /root/webmin_1.680_all.deb
service webmin restart
service vnstat restart

# downlaod script
cd
curl -o "https://raw.githubusercontent.com/orangbiasa/script/master/speedtest_cli.py" > speedtest_cli.py
chmod +x speedtest_cli.py

#monitor limit user
cd /usr/sbin/
curl -o "https://raw.githubusercontent.com/orangbiasa/script/master/userlmt.sh"
curl -o "https://raw.githubusercontent.com/orangbiasa/script/master/usermon.sh"
chmod 755 usermon.sh
chmod 755 userlmt.sh
curl -o "https://raw.githubusercontent.com/orangbiasa/script/master/autokill.sh"
chmod +x autokill.sh
screen -AmdS check /usr/sbin/autokill.sh
sed -i '$ i\screen -AmdS check /usr/sbin/autokill.sh' /etc/rc.local

# finalisasi
cd
service vnstat restart
service ssh restart
service dropbear restart
service fail2ban restart
service webmin restart

#user
curl -o "https://raw.githubusercontent.com/orangbiasa/script/master/user-add.sh"
chmod +x user-add.sh
./user-add.sh ri ri
./user-add.sh vito vito12345
./user-add.sh anisa anisa12345
./user-add.sh fadilah fadilah12345
./user-add.sh yudi yudi12345
./user-add.sh jaya jaya12345
./user-add.sh wasiso wasiso12345
./user-add.sh nyoman nyoman12345
./user-add.sh tirta tirta12345
./user-add.sh vincent vincent12345






