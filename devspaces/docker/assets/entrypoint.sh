#!/bin/bash

# Immediately exits on error
set -o errexit


# Directory with services
SV_DIR="/etc/service"
RUNSVDIR_PID=""


DB_ROOT_PASS=${DB_ROOT_PASS:-Y0uShallN0tPa$$}

DB_NAME=${DB_NAME:-}
DB_USER=${DB_USER:-gandalf}
DB_PASS=${DB_PASS:-shadowfax2014}


# Capturing stop signal from Docker daemon and gracefully stop services
function shutdown {
  echo "Shutting down services..."

  # XXX: you can't use globbing inside trap handler so we need to build service list manually
  SERVICES=`find $SV_DIR -mindepth 1 -maxdepth 1 -type d -not -name '\.*' | xargs echo`

  # force-stop will send SIGTERM and 7 seconds for service stop; then it will send SIGKILL
  if [ -n "$SERVICES" ]; then
    sv force-stop $SERVICES
  fi

  # Stop runit
  kill -HUP $RUNSVDIR_PID && wait $RUNSVDIR_PID
}

function start_rundir() {
    # Start runit in the background
    /usr/bin/runsvdir -P $SV_DIR &
    RUNSVDIR_PID=$!

    echo "Started runsvdir, PID is $RUNSVDIR_PID"

    trap shutdown SIGTERM SIGHUP

    # Wait for runit to exit
    wait $RUNSVDIR_PID
}

function configure_mysql() {
    /usr/bin/mysqld_safe &

    sleep 5

    /usr/bin/mysqladmin -u root password ${DB_ROOT_PASS}

    SQL1="create database ${DB_NAME}";
    echo $SQL1
    mysql -u root -p${DB_ROOT_PASS} -e "${SQL1}"

    SQL2="grant all privileges ON \`${DB_NAME}\`.* to \"${DB_USER}\"@\"%\" identified by \"${DB_PASS}\";"
    echo $SQL2
    mysql -u root -p${DB_ROOT_PASS} -e "${SQL2}"

    SQL3="create database ${DB_NAME}_test";
    echo $SQL3
    mysql -u root -p${DB_ROOT_PASS} -e "${SQL3}"

    SQL4="grant all privileges ON \`${DB_NAME}_test\`.* to \"${DB_USER}\"@\"%\" identified by \"${DB_PASS}\";"
    echo $SQL4
    mysql -u root -p${DB_ROOT_PASS} -e "${SQL4}"

    SQL5="FLUSH PRIVILEGES;"
    echo $SQL5
    mysql -u root -p${DB_ROOT_PASS} -e "${SQL5}"

    mysqladmin -u root -p${DB_ROOT_PASS} shutdown
}


# main:
#   - initialize mysql db
#   - initialize runit service
main() {
    configure_mysql

    start_rundir

    tail -f /dev/null
}

#Execute main routine with environment vars
main "$@"
