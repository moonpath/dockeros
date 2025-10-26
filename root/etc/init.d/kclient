#!/bin/sh
### BEGIN INIT INFO
# Provides:          myservice
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start myservice at boot time
# Description:       Enable service provided by daemon myservice.
### END INIT INFO

PATH="/bin:/usr/bin:/sbin:/usr/sbin"
DESC="kclient service"
NAME="kclient"
DAEMON="/usr/bin/node"
DAEMONOPTS="/usr/local/lib/kclient/index.js"
PIDFILE="/var/run/kclient.pid"
SCRIPTNAME="/etc/init.d/$NAME"
EXEUSER="admin"

. /lib/lsb/init-functions

case "$1" in
    start)
        log_daemon_msg "Starting service" "$NAME"
        start-stop-daemon --start --background --pidfile $PIDFILE --make-pidfile --user $EXEUSER --chuid $EXEUSER --exec $DAEMON -- $DAEMONOPTS
        log_end_msg $?
        ;;
    stop)
        log_daemon_msg "Stopping service" "$NAME"
        start-stop-daemon --stop --quiet --oknodo --retry 30 --pidfile $PIDFILE
        pkill -xf "$DAEMON $DAEMONOPTS" || true
        RETVAL="$?"
        log_end_msg $RETVAL
        rm -f "$PIDFILE"
        if [ $RETVAL != 0 ]; then
            exit 1
        fi
        rm -f "$PIDFILE"
        ;;
    restart)
        log_daemon_msg "Restarting service" "$NAME"
        $0 stop
        $0 start
        ;;
    status)
        status_of_proc -p "$PIDFILE" "$DAEMON" "$NAME" && exit 0 || exit $?
        ;;
    *)
        echo "Usage: $0 {start|stop|status|restart}"
        exit 1
        ;;
esac
exit 0