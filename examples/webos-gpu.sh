#!/bin/bash
sudo docker run -itd \
--runtime nvidia \
--gpus all \
--privileged \
--hostname linux \
--shm-size 8g \
-e VNC_PORT=7900 \
-e VNC_USER=admin \
-e VNC_PASSWD=123456 \
-p 7900:7900 \
--name webos-gpu \
moonpath/webos-gpu:latest
