#!/bin/bash
# Debian 9 & 10 64bit
# Ubuntu 18.04 & 20.04 bit
# Centos 7 & 8 64bit 
# By AnuyBazoelk
# My Telegram : https://t.me/AnuyBazoelk
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
# Getting
ipsaya=$(wget -qO- ipinfo.io/ip)
data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
date_list=$(date +"%Y-%m-%d" -d "$data_server")
data_ip="https://raw.githubusercontent.com/Kulanbagong1/izinn/main/ip"
checking_sc() {
  useexp=$(wget -qO- $data_ip | grep $ipsaya | awk '{print $3}')
  if [[ $date_list < $useexp ]]; then
    echo -ne
  else
    echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
    echo -e "\033[42m          404 NOT FOUND AUTOSCRIPT          \033[0m"
    echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
    echo -e ""
    echo -e "            ${RED}PERMISSION DENIED !${NC}"
    echo -e "   \033[0;33mYour VPS${NC} $ipsaya \033[0;33mHas been Banned${NC}"
    echo -e "     \033[0;33mBuy access permissions for scripts${NC}"
    echo -e "             \033[0;33mContact Admin :${NC}"
    echo -e "      \033[0;36mTelegram${NC} t.me/Jengkol_Online"
    echo -e "      ${GREEN}WhatsApp${NC} wa.me/6282372139631"
    echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
    exit
  fi
}
checking_sc
clear
# ==================================================
# Link Hosting Kalian
bzvpn="raw.githubusercontent.com/Jengkolonline/XRAY/main/foldder/wireguard"

# Check OS version
if [[ -e /etc/debian_version ]]; then
	source /etc/os-release
	OS=$ID # debian or ubuntu
elif [[ -e /etc/centos-release ]]; then
	source /etc/os-release
	OS=centos
fi

Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[information]${Font_color_suffix}"

if [[ -e /etc/wireguard/params ]]; then
	echo -e "${Info} WireGuard sudah diinstal, silahkan ketik addwg untuk menambah client."
	exit 1
fi

echo -e "${Info} Wireguard Script By AnuyBazoelk"
# Detect public IPv4 address and pre-fill for the user

# Detect public interface and pre-fill for the user
SERVER_PUB_NIC=$(ip -o $ANU -4 route show to default | awk '{print $5}');

# Install WireGuard tools and module
	if [[ $OS == 'ubuntu' ]]; then
	apt install -y wireguard
elif [[ $OS == 'debian' ]]; then
	echo "deb http://deb.debian.org/debian/ unstable main" >/etc/apt/sources.list.d/unstable.list
	printf 'Package: *\nPin: release a=unstable\nPin-Priority: 90\n' >/etc/apt/preferences.d/limit-unstable
	apt update
	apt install -y wireguard-tools iptables iptables-persistent
	apt install -y linux-headers-$(uname -r)
elif [[ ${OS} == 'centos' ]]; then
	curl -Lo /etc/yum.repos.d/wireguard.repo https://copr.fedorainfracloud.org/coprs/jdoss/wireguard/repo/epel-7/jdoss-wireguard-epel-7.repo
	yum -y update
	yum -y install wireguard-dkms wireguard-tools
	fi
apt install iptables iptables-persistent -y
# Make sure the directory exists (this does not seem the be the case on fedora)
mkdir /etc/wireguard >/dev/null 2>&1

chmod 600 -R /etc/wireguard/

SERVER_PRIV_KEY=$(wg genkey)
SERVER_PUB_KEY=$(echo "$SERVER_PRIV_KEY" | wg pubkey)

# Save WireGuard settings
echo "SERVER_PUB_NIC=$SERVER_PUB_NIC
SERVER_WG_NIC=wg0
SERVER_WG_IPV4=10.66.66.1
SERVER_PORT=7070
SERVER_PRIV_KEY=$SERVER_PRIV_KEY
SERVER_PUB_KEY=$SERVER_PUB_KEY" >/etc/wireguard/params

source /etc/wireguard/params

# Add server interface
echo "[Interface]
Address = $SERVER_WG_IPV4/24
ListenPort = $SERVER_PORT
PrivateKey = $SERVER_PRIV_KEY
PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o $SERVER_PUB_NIC -j MASQUERADE;
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o $SERVER_PUB_NIC -j MASQUERADE;" >>"/etc/wireguard/wg0.conf"

iptables -t nat -I POSTROUTING -s 10.66.66.1/24 -o $SERVER_PUB_NIC -j MASQUERADE
iptables -I INPUT 1 -i wg0 -j ACCEPT
iptables -I FORWARD 1 -i $SERVER_PUB_NIC -o wg0 -j ACCEPT
iptables -I FORWARD 1 -i wg0 -o $SERVER_PUB_NIC -j ACCEPT
iptables -I INPUT 1 -i $SERVER_PUB_NIC -p udp --dport 7070 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

systemctl start "wg-quick@wg0"
systemctl enable "wg-quick@wg0"

# Check if WireGuard is running
systemctl is-active --quiet "wg-quick@wg0"
WG_RUNNING=$?

# Tambahan
cd /usr/bin
wget -O addwg "https://${bzvpn}/addwg.sh"
wget -O delwg "https://${bzvpn}/delwg.sh"
wget -O renewwg "https://${bzvpn}/renewwg.sh"
chmod +x addwg
chmod +x delwg
chmod +x renewwg
cd
rm -f /root/wg.sh
