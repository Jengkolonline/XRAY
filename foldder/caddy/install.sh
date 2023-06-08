#!/bin/bash
REPO="https://raw.githubusercontent.com/Jengkolonline/XRAY/main/"

curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg --yes  >/dev/null 2>&1
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list  >/dev/null 2>&1
sudo apt install caddy

### Tambah konfigurasi Caddy
function caddy(){
    mkdir -p /etc/caddy
    wget -O /etc/caddy/socks5 "${REPO}foldder/caddy/socks5" >/dev/null 2>&1
    wget -O /etc/caddy/ssgrpc "${REPO}foldder/caddy/ssgrpc" >/dev/null 2>&1
    wget -O /etc/caddy/ssnone "${REPO}foldder/caddy/ssnone" >/dev/null 2>&1
    wget -O /etc/caddy/ssws "${REPO}foldder/caddy/ssws" >/dev/null 2>&1
    wget -O /etc/caddy/trojan "${REPO}foldder/caddy/trojan" >/dev/null 2>&1
    wget -O /etc/caddy/trojangrpc "${REPO}foldder/caddy/trojangrpc" >/dev/null 2>&1
    wget -O /etc/caddy/trojannone "${REPO}foldder/caddy/trojannone" >/dev/null 2>&1
    wget -O /etc/caddy/trojantcp "${REPO}foldder/caddy/trojantcp" >/dev/null 2>&1
    wget -O /etc/caddy/vless "${REPO}foldder/caddy/vless" >/dev/null 2>&1
    wget -O /etc/caddy/vlessgrpc "${REPO}foldder/caddy/vlessgrpc" >/dev/null 2>&1
    wget -O /etc/caddy/vlessh2 "${REPO}foldder/caddy/vlessh2" >/dev/null 2>&1
    wget -O /etc/caddy/vlesskcp "${REPO}foldder/caddy/vlesskcp" >/dev/null 2>&1
    wget -O /etc/caddy/vlessnone "${REPO}foldder/caddy/vlessnone" >/dev/null 2>&1
    wget -O /etc/caddy/vmess "${REPO}foldder/caddy/vmess" >/dev/null 2>&1
    wget -O /etc/caddy/vmessgrpc "${REPO}foldder/caddy/vmessgrpc" >/dev/null 2>&1
    wget -O /etc/caddy/vmesshttp "${REPO}foldder/caddy/vmesshttp" >/dev/null 2>&1
    wget -O /etc/caddy/vmesshttp2 "${REPO}foldder/caddy/vmesshttp2" >/dev/null 2>&1
    wget -O /etc/caddy/vmesskcp "${REPO}foldder/caddy/vmesskcp" >/dev/null 2>&1
    wget -O /etc/caddy/vmessnone "${REPO}foldder/caddy/vmessnone" >/dev/null 2>&1
    wget -O /etc/caddy/vmessquic "${REPO}foldder/caddy/vmessquic" >/dev/null 2>&1
    wget -O /etc/caddy/vmesstcp "${REPO}foldder/caddy/vmesstcp" >/dev/null 2>&1
    cat >/etc/caddy/Caddyfile <<-EOF
$domain:443
{
    tls taibabi17@gmail.com
    encode gzip

    import vless
    handle_path /vless {
        reverse_proxy localhost:10001

    }

    import vmess
    handle_path /vmess {
        reverse_proxy localhost:10002
    }

    import trojan
    handle_path /trojan-ws {
        reverse_proxy localhost:10003
    }

    import ss
    handle_path /ss-ws {
        reverse_proxy localhost:10004
    }

    handle {
        reverse_proxy https://$domain {
            trusted_proxies 0.0.0.0/0
            header_up Host {upstream_hostport}
        }
    }
}
EOF
}

caddy
systemctl stop caddy
systemctl enable --now caddy
