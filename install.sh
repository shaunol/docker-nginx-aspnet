#!/bin/bash
exec /usr/bin/fastcgi-mono-server4 /applications=/:/usr/aspnet/ /socket=tcp:127.0.0.1:9000 &
exec /usr/sbin/nginx &
exec tail -f /usr/aspnet/packages.config
