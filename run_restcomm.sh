#!/bin/bash
#A good script for running restcomm in docker
docker run -e MEDIASERVER_LOWEST_PORT="65000" \
-e MEDIASERVER_HIGHEST_PORT="65050" \
-e VOICERSS_KEY="put your key here" \
-e STATIC_ADDRESS=$(docker-machine ip) \
-e USE_STANDARD_HTTP_PORTS="true" \
-e USE_STANDARD_SIP_PORTS="true" \
--name=restcomm -d \
-p 80:80 \
-p 443:443 \
-p 9990:9990 \
-p 5060:5060 \
-p 5061:5061 \
-p 5062:5062 \
-p 5063:5063 \
-p 5060:5060/udp \
-p 65000-65050:65000-65050/udp \
restcomm/restcomm:latest
