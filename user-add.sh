useradd -g sshlimit -M -s /bin/false $1
echo "$1:$2" | chpasswd
