#!/bin/bash
#
#  This script builds the kamailio image
#  Usage: buildImage.sh <HOST_IP_ADDRESS>
#
#----------------------------------------------------------------------
if [ $# -eq 0 ]
then
    echo "Usage: buildImage.sh <HOST_IP_ADDRESS>";
else
    docker build -t docker_kamailio:latest --build-arg HOST_IP=$1 .
fi
