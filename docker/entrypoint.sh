#!/bin/sh

cat <<EOF > /usr/share/nginx/html/assets/environment.json
{
  "hpApiUrl": "${HP_API_URL}"
}
EOF

nginx -g 'daemon off;'