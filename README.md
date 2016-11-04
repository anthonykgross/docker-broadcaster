# What is Anthonykgross/Docker-broadcaster ?
This image allows you to broadcast your stream to several live streaming video platforms (Twitch, Hitbox, Youtube and Dailymotion) in the same time. Just broadcast your stream to your container and it will broadcast to your favorites platforms.

Features include:
- Transcode your stream and broadcast it to others platforms (beta).
- Broadcast your stream to others platforms.

# How to use 

You can read my post about it (French) : http://anthonykgross.fr/p/multi-streaming-broadcaster-twitch-youtube-dailymotion-hitbox 

##Prerequisites
Add your user to docker group to be able to use it with non root user: 
```console
$ sudo usermod -aG docker username
```

## Get docker-broadcaster
Download the repository on your public server.
```console
$ docker run --name my-broadcaster [ -e parameters ] anthonykgross/docker-broadcaster
```
or
```console
$ apt-get install git # For debian
$ git clone https://github.com/anthonykgross/docker-broadcaster.git
$ cd docker-broadcaster/
$ docker-compose up -d
```

## Parameters
- **YOUTUBE_URL** (default : "rtmp://a.rtmp.youtube.com/live2") 
 * Set your RTMP-URL from Youtube.  
- **YOUTUBE_STREAMKEY** (default : "NULL")
 * Set your Stream Name or Stream Key from Youtube.  
- **TWITCH_URL** (default : "rtmp://live-cdg.twitch.tv/app")
 * Set your Stream RTMP from Twitch.  
- **TWITCH_STREAMKEY** (default : "NULL")
 * Set your Stream Key from Twitch. 
- **HITBOX_URL** (default : "rtmp://live.hitbox.tv/push")
 * Set your Stream RTMP from Hitbox. 
- **HITBOX_STREAMKEY** (default : "NULL")
 * Set your Stream Key from Hitbox. 
- **DAILYMOTION_URL** (default : "rtmp://publish.dailymotion.com/publish-dm")
 * Set your Stream RTMP from Dailymotion. 
- **DAILYMOTION_STREAMKEY** (default :"NULL")
 * Set your Stream RTMP from Dailymotion. 
- **YOUR_IP** (default : "YOUR_IP")
 * Set your server's IP : Only useful in docker's logs. 
- **PRIVATE_KEY** (default : "anthonykgross")
 * Set your private key. Advise : generate a randomly string [A-Za-Z0-9]. 
- **EXPIRATION_TOKEN** (default : 3600)
 * Set how long (in seconds) your token will be valid. 
- **STREAM_SPECIFIER** (default : "hd720")
 * Set the video's size that you want to broadcast to others platforms.
- **URL_TRANSCODE** (default : "transcode")
 * Set the url that you want for transcoding. Default rtpm://...:1935/transcode
- **URL_LIVE** (default : "live")
 * Set the url that you want to watch (on play) or to broadcast (on publish). Default rtpm://...:1935/live
 
You can edit parameters in `docker-compose.yml` or define them with `-e [environment_var]` with `docker run`.
And it's finished ! Just run your container !

# Show your broadcaster informations
```console
$ docker logs my-broadcaster
```
```console
broadcaster_1 | ===============================================================================================
broadcaster_1 | =
broadcaster_1 | = TWITCH_STREAMKEY      : live_101724967_qLZMlwnxxpKqsqsfJ5lNcBcP0RYtpw
broadcaster_1 | = HITBOX_STREAMKEY      : qsfqf?key=Jn6Dsqdqsd8cpx
broadcaster_1 | = YOUTUBE_STREAMKEY     : poopaplla-7537.ea0k-ef3-czsz
broadcaster_1 | = DAILYMOTION_STREAMKEY : 24646?auth=qeGP_9fb42e109944fa5b504e191
broadcaster_1 | =
broadcaster_1 | = URL live            = rtmp://xxx.xxx.xxx.xxx:1935/live/
broadcaster_1 | = URL transcode       = rtmp://xxx.xxx.xxx.xxx:1935/transcode/
broadcaster_1 | = Stream Key          = stream?e=1441722597&st=wxcwxcazeee
broadcaster_1 | = Expiration token    = 09-08-2015 02:29:57 PM (in 3600 sec.)
broadcaster_1 | =
broadcaster_1 | ===============================================================================================
```

# Configure
In OBS (Open Broadcast Software) or XplitBroadcaster :
```console
RTMP URL :                            # Warning : "live" or "transcode" is defaults values. Change them with yours.
rtmp://xxx.xxx.xxx.xxx:1935/live/ or rtmp://xxx.xxx.xxx.xxx:1935/transcode/ 

Stream key/playpath/login/token/... : # Change with yours
stream?e=1441722597&st=wxcwxcazeee 
```

## Creator
**Anthony K GROSS**
- <http://anthonykgross.fr>
- <https://twitter.com/anthonykgross>
- <https://github.com/anthonykgross>

## Contributors

**Gregory GROSS** 
- I would like to thank my brother for his idea and to help me to develop this image. I hope that he will be broadcast his stream for each platform without bugs :)

**Clément VIDAL** 
- Thank you for your help, you know my english's level is very low !

**Kalyzee Team**
- Thank you for my promote ! [Kalyzee - Video Interactive](http://www.kalyzee.com/)

## Copyright and license
Code and documentation copyright 2015. Code released under [the MIT license](https://github.com/kkuetnet/Harproject/blob/master/LICENSE).

