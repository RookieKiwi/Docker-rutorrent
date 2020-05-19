# Docker-rutorrent

ruTorrent with Autodl-irssi and SSL

I will document one of these days!

## Ports to map
31337 = rutorrent non-ssl port / 31338 = scgi port / 31339 = rtorrent port / 31340 = rutorrent ssl port / 31341 = DHT port (disabled by default)

## Folders to map

/app/downloads = Downloads folder
/app/configs = Configuration files folder

## Side notes
/app/downloads/watch = Watchlist directory, any .torrent files put here will automatically be pulled into rtorrent
/app/configs/logs = Logging directory for any troubleshooting required
/app/configs/rtorrent/rtorrent.rc = Main rTorrent configuration file, linked directly to rTorrent client
/app/configs/rutorrent/torrents = Where downloaded torrent files sit
/app/configs/config.php = ruTorrent configuration file

Enjoy!