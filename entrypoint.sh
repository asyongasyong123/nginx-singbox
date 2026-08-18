
#!/bin/sh
set -e

echo "✅ Starting Sing-Box..."
sing-box run -c /etc/sing-box/config.json &
sleep 3

echo "✅ Starting Nginx..."
nginx -g "daemon off;"
