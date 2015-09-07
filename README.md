# What is Anthonykgross/Docker-broadcaster ?
This image allows you to broadcast your stream to several live streaming video platforms (Twitch, Hitbox and others soon) in the same time. Just broadcast your stream to your container and it will broadcast to your favorites platforms.

# HOW TO USE

## Get docker-broadcaster
Download the repository on your public server.
```bash
$ apt-get install git # For debian
$ git clone https://github.com/anthonykgross/docker-broadcaster.git
$ cd docker-broadcaster/
```

## Configure your accounts
in conf/nginx/nginx.conf
```js
...
rtmp {
    server {
        ...
        application live {
             ...
             #Add your accounts with API_KEY
             
             # With Twitch.tv, you can choose streaming server : Here Europe/Paris
             push rtmp://live-cdg.twitch.tv/app/<your_twitch_key>;
             
             #Hitbox
             #push rtmp://live.hitbox.tv/push/<your_hitbox_key>;
        }
    }
}
```
And it's finished ! Just run your container !

## Run
Run the container with docker-compose

in docker-broadcaster/
```js
docker-compose up -d
```

# Configure
In OBS (Open Broadcast Software) or XplitBroadcaster, configure the RTMP server with :
```bash
rtmp://your_ip_server:1935/transcode (If you want to transcode before broadcasting)
or 
rtmp://your_ip_server:1935/live (If you want only to broadcast)
```

