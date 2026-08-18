
# ==========================================
# 🚀 KIANA — Nginx + Sing-Box
# ✅ Health Check | ✅ Picture Proxy | ✅ Trojan+WS | ✅ VLESS+WS
# ✅ Cloud Run Ready | ✅ Qwiklabs Safe
# ==========================================

FROM alpine:3.20

# Install Nginx + dependencies
RUN apk update --no-cache && \
    apk add --no-cache nginx curl tzdata wget && \
    # Download Sing-Box v1.10.1
    wget -O /tmp/sing-box.tar.gz https://github.com/SagerNet/sing-box/releases/download/v1.10.1/sing-box-1.10.1-linux-amd64.tar.gz && \
    tar -xzf /tmp/sing-box.tar.gz -C /tmp && \
    cp /tmp/sing-box-1.10.1-linux-amd64/sing-box /usr/bin/ && \
    chmod +x /usr/bin/sing-box && \
    # Cleanup
    rm -rf /tmp/sing-box* /var/cache/apk/*

# Create directories
RUN mkdir -p /etc/sing-box /run/nginx /var/log/nginx

# Copy config files
COPY nginx.conf /etc/nginx/nginx.conf
COPY sing-box.json /etc/sing-box/config.json
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose Cloud Run port
EXPOSE 8080

# Start services
CMD ["/entrypoint.sh"]
