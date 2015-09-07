# What is Anthonykgross/Docker-broadcaster ?
This image allows you to broadcast your stream to several live streaming video platforms (Twitch, Hitbox and others soon) in the same time. Just broadcast your stream to your container and it will broadcast to your favorites platforms.

# HOW TO USE

## Configure your accounts
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
             #push rtmp://live-cdg.twitch.tv/app/<your_twitch_key>;
             
             #Hitbox
             #push rtmp://live.hitbox.tv/push/<your_hitbox_key>;
        }
    }
}
```
And it's finished ! Just run your container !

## 

```js
docker-compose up
```



