# Docker-rutorrent

ruTorrent with Autodl-irssi and SSL

Ill document one of these days! Quick notes:

Ports:
31337 = rutorrent non-ssl port
31340 = rutorrent ssl port
31338 = scgi port
31339 = rtorrent port

Folders to map

/app/downloads = Downloads folder, "watch" folder will be created in this folder to drop any .torrent files you need in there.

/app/configs = Configuration files folder, will also create "logs" folder here for troubleshooting, Also if you want SSL here is where you put your nginx.crt / nginx.key files for SSL.

Enjoy!