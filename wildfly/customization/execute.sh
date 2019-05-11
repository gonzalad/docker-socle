#!/bin/bash

# see https://goldmann.pl/blog/2014/07/23/customizing-the-configuration-of-the-wildfly-docker-image/

# JBOSS_HOME=/opt/wildfly
JBOSS_CLI=$JBOSS_HOME/bin/jboss-cli.sh
JBOSS_MODE=${1:-"standalone"}
JBOSS_CONFIG="$JBOSS_MODE.xml"

function wait_for_server() {
  until `$JBOSS_CLI -c "ls /deployment" &> /dev/null`; do
    sleep 1
  done
}

if [ "$#" -lt 2 ]; then
	echo "Arguments required, usage: execute.sh <mode> <script1.cli>..."
  echo "  mode=standalone"
  echo "  script=list of jboss cli scripts to execute"
	exit 1
fi

echo "=> Starting WildFly server"
$JBOSS_HOME/bin/$JBOSS_MODE.sh -c $JBOSS_CONFIG --admin-only -b 0.0.0.0 -bmanagement 0.0.0.0 > /dev/null &

echo "=> Waiting for the server to boot"
wait_for_server

echo "=> Executing the commands"
# we remove first parameter to leave only script parameters
shift
for i in "$@"; do
  echo "=> Executing commands: $i"
  if [ ! -f "$i" ]; then
    echo "File $i doesn't exist."
    exit 1
  fi
	#$JBOSS_CLI -c --file=`dirname "$0"`/commands.cli
	$JBOSS_CLI -c --file=$i
done

echo "=> Shutting down WildFly"
if [ "$JBOSS_MODE" = "standalone" ]; then
  $JBOSS_CLI -c ":shutdown"
else
  $JBOSS_CLI -c "/host=*:shutdown"
fi