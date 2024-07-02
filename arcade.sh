#!/bin/sh

SLACK_ID="<your slack id>"
API_KEY="<your api key>"

if [ "$(date +%S)" == "00" ] || [[ ! -s "/tmp/arcade" ]]; then
    response=$(curl -H "Authorization: Bearer $API_KEY" -H "User-Agent: _bg's nvim arcade integration" https://hackhour.hackclub.com/api/session/$SLACK_ID 2>/dev/null)
    echo $response >/tmp/arcade
else
    response=$(cat /tmp/arcade)
fi

if [ "$((60 - $(echo $response | jq .data.elapsed)))" == "0" ]; then
    printf "no session"
else
    printf " $((60 - $(echo $response | jq .data.elapsed))) - $(echo $response | jq -r .data.goal)"
fi
