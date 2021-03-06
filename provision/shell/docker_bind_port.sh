#!/bin/bash

echo "Binding Docker daemon to port 2375..."

DOCKER_OPTS="DOCKER_OPTS=\"-H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock\""

if grep -Fxq $DOCKER_OPTS /etc/default/docker
then
    echo "Already configured!"
else
    echo $DOCKER_OPTS > /etc/default/docker
    service docker restart
    echo "Done!"
fi