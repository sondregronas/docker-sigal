#!/bin/bash
service cron start
sigal build -n 1 --title "$GALLERY_TITLE"
exec nginx -g "daemon off;"
