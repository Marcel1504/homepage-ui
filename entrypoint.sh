#!/bin/sh

cat <<EOF > /usr/share/nginx/html/assets/configs/environment.json
{
  "hpApiUrl": "${HP_API_URL}"
  "hpChatConsent": "${HP_CHAT_CONSENT}"
}
EOF

nginx -g 'daemon off;'