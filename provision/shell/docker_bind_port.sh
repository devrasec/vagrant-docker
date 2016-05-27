#!/bin/bash

echo "Binding Docker daemon to port 2375..."
if grep -Fxq 'DOCKER_OPTS="-H tcp://0.0.0.0:2375"' /etc/default/docker
then
    echo "Already configured!"
else
    echo 'DOCKER_OPTS="-H tcp://0.0.0.0:2375"' >> /etc/default/docker
    service docker restart
    echo "Done!"
fi