#! /bin/bash
docker run -it --network=host -v $HOME/collectd:/collectd --privileged localhost/collectd-rpm-build

CONTAINER_ID=$(docker ps --latest | awk '{ print $1 }' | tail -1)

echo container id: $CONTAINER_ID

rm -rf ./RPMS/*
docker cp $CONTAINER_ID:/RPMS/ .

