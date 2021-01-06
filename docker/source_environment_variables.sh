#!/bin/bash
export NB_UID=$(id -u)
export NB_GID=$(id -g)
export NB_USER=$(whoami)
if [ -z ${HOSTNAME+x} ]
then 
	export HOSTNAME=$(hostname)
	echo "SETTING HOSTNAME = '$HOSTNAME'"
else 
	echo "HOSTNAME = '$HOSTNAME'"
fi

export HTTP_USER=user
export HTTP_AUTH_PASS_ENC="\$apr1\$0rh0Tkr3\$ALeFxLzN7Q7m7fvaBFB8H0"
