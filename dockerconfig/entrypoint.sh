#!/bin/bash
set -x

sudo chown `whoami`:`whoami` $HOME
cp -n /etc/skel/.bashrc /etc/skel/.profile /etc/skel/.bash_logout $HOME/

if [ ! $VNC_PORT ]; then
    VNC_PORT=7900
fi
if [ ! $VNC_USER ]; then
    VNC_USER=user
fi
if [ ! $VNC_PASSWD ]; then
    VNC_PASSWD=password
fi
if [ ! $SUBFOLDER ]; then
    SUBFOLDER=/
fi
echo -e "$VNC_PASSWD\n$VNC_PASSWD\n" | vncpasswd -u $VNC_USER -o -w -r
rm -rf /tmp/.X1-lock /tmp/.X11-unix
vncserver -select-de XFCE -disableBasicAuth -SecurityTypes None -sslOnly 0 -localhost 1 -websocketPort 6901 :1

sudo sed -i "s/EXEUSER=\"[^\"]*\"/EXEUSER=\"`whoami`\"/" /etc/init.d/kclient

sudo ln -s /etc/nginx/sites-available/webos /etc/nginx/sites-enabled/webos
sudo sed -i "s/\$HTTP_PORT/$VNC_PORT/" /etc/nginx/sites-available/webos
sudo sed -i "s/\$HTTPS_PORT/$((VNC_PORT+1))/" /etc/nginx/sites-available/webos
sudo sed -i "s|\$SUBFOLDER|$SUBFOLDER|g" /etc/nginx/sites-available/webos
printf "${VNC_USER}:$(openssl passwd -apr1 ${VNC_PASSWD})\n" | sudo tee /etc/nginx/.htpasswd >>/dev/null

if [ ! -z ${VNC_AUTH+x} ]; then
  sudo sed -i 's/#//g' /etc/nginx/sites-available/webos
fi

sudo service dbus start
pulseaudio --start --disallow-exit --exit-idle-time=-1
sudo service kclient start
sudo service nginx start

mkdir -p $HOME/Desktop

cp -n /usr/share/applications/code.desktop $HOME/Desktop/code.desktop
chmod 755 $HOME/Desktop/code.desktop

cp -n /usr/share/applications/microsoft-edge.desktop $HOME/Desktop/microsoft-edge.desktop
chmod 755 $HOME/Desktop/microsoft-edge.desktop

cp -n /usr/local/share/JetBrains/Toolbox/jetbrains-toolbox.desktop $HOME/Desktop/
chmod 755 $HOME/Desktop/jetbrains-toolbox.desktop

if [ -f ~/.startup ]; then
    . ~/.startup
fi

set -ex
exec "$@"
