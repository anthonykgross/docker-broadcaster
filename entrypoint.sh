#!/bin/bash
set -e

source ~/.bash_profile

run() {
    sed -i -e "s,<url_transcode>,$URL_TRANSCODE,g" /usr/local/nginx-streaming/conf/nginx.conf
    sed -i -e "s,<url_live>,$URL_LIVE,g" /usr/local/nginx-streaming/conf/nginx.conf
    sed -i -e "s,<stream_specifier>,$STREAM_SPECIFIER,g" /usr/local/nginx-streaming/conf/nginx.conf
    sed -i -e "s,<private_key>,$PRIVATE_KEY,g" /usr/local/nginx-streaming/conf/nginx.conf

    sed -i -e "s,<twitch_url>,$TWITCH_URL,g" /usr/local/nginx-streaming/conf/nginx.conf
    sed -i -e "s,<hitbox_url>,$HITBOX_URL,g" /usr/local/nginx-streaming/conf/nginx.conf
    sed -i -e "s,<youtube_url>,$YOUTUBE_URL,g" /usr/local/nginx-streaming/conf/nginx.conf
    sed -i -e "s,<dailymotion_url>,$DAILYMOTION_URL,g" /usr/local/nginx-streaming/conf/nginx.conf
    sed -i -e "s,<livecoding_url>,$LIVECODING_URL,g" /usr/local/nginx-streaming/conf/nginx.conf

    echo "==============================================================================================="
    echo "="
    if [[ $TWITCH_STREAMKEY != "NULL" ]]
    then
        echo "= TWITCH_STREAMKEY      : $TWITCH_STREAMKEY"
        sed -i -e "s,<twitch_active>, ,g" /usr/local/nginx-streaming/conf/nginx.conf
        sed -i -e "s,<twitch_streamkey>,$TWITCH_STREAMKEY,g" /usr/local/nginx-streaming/conf/nginx.conf

    else
        echo "= TWITCH_STREAMKEY      : NOT FOUND!"
        sed -i -e "s,<twitch_active>,#,g" /usr/local/nginx-streaming/conf/nginx.conf
    fi

    if [[ $HITBOX_STREAMKEY != "NULL" ]]
    then
        echo "= HITBOX_STREAMKEY      : $HITBOX_STREAMKEY"
        sed -i -e "s,<hitbox_active>, ,g" /usr/local/nginx-streaming/conf/nginx.conf
        sed -i -e "s,<hitbox_streamkey>,$HITBOX_STREAMKEY,g" /usr/local/nginx-streaming/conf/nginx.conf

    else
        echo "= HITBOX_STREAMKEY      : NOT FOUND!"
        sed -i -e "s,<hitbox_active>,#,g" /usr/local/nginx-streaming/conf/nginx.conf
    fi

    if [[ $YOUTUBE_STREAMKEY != "NULL" ]]
    then
        echo "= YOUTUBE_STREAMKEY     : $YOUTUBE_STREAMKEY"
        sed -i -e "s,<youtube_active>, ,g" /usr/local/nginx-streaming/conf/nginx.conf
        sed -i -e "s,<youtube_streamkey>,$YOUTUBE_STREAMKEY,g" /usr/local/nginx-streaming/conf/nginx.conf

    else
        echo "= YOUTUBE_STREAMKEY     : NOT FOUND!"
        sed -i -e "s,<youtube_active>,#,g" /usr/local/nginx-streaming/conf/nginx.conf
    fi

    if [[ $DAILYMOTION_STREAMKEY != "NULL" ]]
    then
        echo "= DAILYMOTION_STREAMKEY : $DAILYMOTION_STREAMKEY"
        sed -i -e "s,<dailymotion_active>, ,g" /usr/local/nginx-streaming/conf/nginx.conf
        sed -i -e "s,<dailymotion_streamkey>,$DAILYMOTION_STREAMKEY,g" /usr/local/nginx-streaming/conf/nginx.conf

    else
        echo "= DAILYMOTION_STREAMKEY : NOT FOUND!"
        sed -i -e "s,<dailymotion_active>,#,g" /usr/local/nginx-streaming/conf/nginx.conf
    fi

    if [[ $LIVECODING_STREAMKEY != "NULL" ]]
    then
        echo "= LIVECODING_STREAMKEY : $LIVECODING_STREAMKEY"
        sed -i -e "s,<livecoding_active>, ,g" /usr/local/nginx-streaming/conf/nginx.conf
        sed -i -e "s,<livecoding_streamkey>,$LIVECODING_STREAMKEY,g" /usr/local/nginx-streaming/conf/nginx.conf

    else
        echo "= LIVECODING_STREAMKEY : NOT FOUND!"
        sed -i -e "s,<livecoding_active>,#,g" /usr/local/nginx-streaming/conf/nginx.conf
    fi

    today=$(date +%s)
    expire=$(($today+$EXPIRATION_TOKEN))
    token=$(echo -n "$PRIVATE_KEY/stream$expire" | openssl dgst -md5 -binary |
             openssl enc -base64 | tr '+/' '-_' | tr -d '=')
    formatted_date=$(date --date="@$expire" +"%m-%d-%Y %r")

    echo "="
    echo "= Mobile files        = http://$YOUR_IP/"
    echo "= URL live            = rtmp://$YOUR_IP:1935/$URL_LIVE/"
    echo "= URL transcode       = rtmp://$YOUR_IP:1935/$URL_TRANSCODE/"
    echo "= Stream Key          = stream?e=$expire&st=$token"
    echo "= Expiration token    = $formatted_date (in $EXPIRATION_TOKEN sec.)                                          "
    echo "="
    echo "==============================================================================================="

    chown docker /src -Rf
    supervisord
}

case "$1" in
"run")
    echo "Run"
    run
    ;;
*)
    echo "Custom command : $@"
    exec "$@"
    ;;
esac
