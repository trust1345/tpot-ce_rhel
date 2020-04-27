# tpotce_rhel
tpotce Installation script -  on RHEL\CentOS  https://github.com/dtag-dev-sec/tpotce
First version (quick and dirty, but work) of script to install on CentOS\RHEL 7.
There 's a problem with the cockpit start. After the host is restarted, it must be restarted manually (via systemctl).

run on clean installed RHEL7\CentOS7


git clone https://github.com/trust1345/tpotce_rhel.git

cd tpotce_rhel

chmod +x ./*.sh

./run-first.sh
