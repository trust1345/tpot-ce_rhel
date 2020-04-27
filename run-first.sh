#!/bin/bash
# 1 script
## cd tpot_rhel
## chmod +x ./*.sh
## ./run-first.sh

sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config
setenforce 0
systemctl stop firewalld
systemctl mask firewalld

curl https://getfedora.org/static/fedora.gpg | gpg --import
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y
yum update -y
yum install git bash-completion wget dialog iptables-services figlet npm -y

systemctl enable iptables.service

sed -i 's/-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT/#-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT/g' /etc/sysconfig/iptables
sed -i 's/-A INPUT -p icmp -j ACCEPT/#-A INPUT -p icmp -j ACCEPT/g' /etc/sysconfig/iptables
sed -i 's/-A INPUT -i lo -j ACCEPT/#-A INPUT -i lo -j ACCEPT/g' /etc/sysconfig/iptables
sed -i 's/-A INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT/#-A INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT/g' /etc/sysconfig/iptables
sed -i 's/-A INPUT -j REJECT --reject-with icmp-host-prohibited/#-A INPUT -j REJECT --reject-with icmp-host-prohibited/g' /etc/sysconfig/iptables
sed -i 's/-A FORWARD -j REJECT --reject-with icmp-host-prohibited/#-A FORWARD -j REJECT --reject-with icmp-host-prohibited/g' /etc/sysconfig/iptables
systemctl daemon-reload

systemctl start iptables.service


yum remove postfix -y
yum install cockpit-docker cockpit-ws -y
yum install https://download-ib01.fedoraproject.org/pub/fedora/linux/releases/30/Everything/x86_64/os/Packages/g/grc-1.11.3-2.fc30.noarch.rpm  -y

systemctl start docker
systemctl enable docker
systemctl start cockpit.socket
systemctl enable cockpit.socket

sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

git clone https://github.com/dtag-dev-sec/tpotce
/bin/cp -rf install.sh tpotce/iso/installer/

cd tpotce/iso/installer/
./install.sh --type=user
