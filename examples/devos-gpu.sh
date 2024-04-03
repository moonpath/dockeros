#!/bin/bash
sudo docker run -itd \
--runtime nvidia \
--gpus all \
--privileged \
--hostname linux \
-p 2222:22 \
--name devos-gpu \
moonpath/devos-gpu:latest
