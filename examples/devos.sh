#!/bin/bash
sudo docker run -itd \
--privileged \
--hostname linux \
-p 2222:22 \
--name devos \
moonpath/devos:latest
