#!/bin/bash
case $1 in
-dp)
ps ax|grep dropbear > /tmp/pid.txt
cat /var/log/secure |  grep -i "Password auth succeeded" > /tmp/sukses.txt
perl -pi -e 's/Password auth succeeded for//g' /tmp/sukses.txt
perl -pi -e 's/dropbear/PID/g' /tmp/sukses.txt
;;
-op)
clear
ps ax|grep sshd > /tmp/pid.txt
cat /var/log/secure | grep -i ssh | grep -i "Accepted password for" > /tmp/sukses.txt
perl -pi -e 's/Accepted password for//g' /tmp/sukses.txt
perl -pi -e 's/sshd/PID/g' /tmp/sukses.txt
;;
*)
echo "Gunakan perintah usermon -dp  untuk dropbear"
echo " atau usermon -op intuk openssh"
exit 1
;;
esac

echo "=================================================" > /tmp/hasil.txt
echo " **** User SSH  Monitor by Mikodemos v.1 ****" >> /tmp/hasil.txt
cat /tmp/pid.txt | while read line;do
set -- $line
cat /tmp/sukses.txt | grep $1 >> /tmp/hasil.txt
done
echo "=================================================" >> /tmp/hasil.txt
cat /tmp/hasil.txt


