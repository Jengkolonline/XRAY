GITHUB_CMD="https://raw.githubusercontent.com/Jengkolonline/XRAY/main/foldder/jengkolonline/Documentation/"
wget -q -O /etc/systemd/system/limitvmess.service "${GITHUB_CMD}1" && chmod +x limitvmess.service >/dev/null 2>&1
wget -q -O /etc/systemd/system/limitvless.service "${GITHUB_CMD}2" && chmod +x limitvless.service >/dev/null 2>&1
wget -q -O /etc/systemd/system/limittrojan.service "${GITHUB_CMD}3" && chmod +x limittrojan.service >/dev/null 2>&1
wget -q -O /etc/systemd/system/limitshadowsocks.service "${GITHUB_CMD}4" && chmod +x limitshadowsocks.service >/dev/null 2>&1
wget -q -O /etc/systemd/system/limitsocks.service "${GITHUB_CMD}5" && chmod +x limitshadowsocks.service >/dev/null 2>&1
wget -q -O /etc/systemd/system/limitshadowsocks2022.service "${GITHUB_CMD}6" && chmod +x limitshadowsocks.service >/dev/null 2>&1
wget -q -O /etc/xray/limit.vmess "${GITHUB_CMD}vmess" >/dev/null 2>&1
wget -q -O /etc/xray/limit.vless "${GITHUB_CMD}vless" >/dev/null 2>&1
wget -q -O /etc/xray/limit.trojan "${GITHUB_CMD}trojan" >/dev/null 2>&1
wget -q -O /etc/xray/limit.shadowsocks "${GITHUB_CMD}shadowsocks" >/dev/null 2>&1
wget -q -O /etc/xray/linit.socks "${GITHUB_CMD}socks" >/dev/null 2>&1
wget -q -O /etc/xray/linit.shadowsocks2022 "${GITHUB_CMD}shadowsocks2022" >/dev/null 2>&1
chmod +x /etc/xray/limit.vmess
chmod +x /etc/xray/limit.vless
chmod +x /etc/xray/limit.trojan
chmod +x /etc/xray/limit.shadowsocks
chmod +x /etc/xray/limit.socks
chmod +x /etc/xray/limit.shadowsocks2022
systemctl daemon-reload
systemctl enable limitvmess
systemctl enable limitvless
systemctl enable limittrojan
systemctl enable limitshadowsocks
systemctl enable limitsocks
systemctl enable limitshadowsocks2022
systemctl start limitvmess
systemctl start limitvless
systemctl start limittrojan
systemctl start limitshadowsocks
systemctl start limitsocks
systemctl start limitshadowsocks2022
systemctl restart limitvmess
systemctl restart limitvless
systemctl restart limittrojan
systemctl restart limitshadowsocks
systemctl restart limitsocks
systemctl restart limitshadowsocks2022
