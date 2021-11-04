#!/usr/bin/env bash

kubectl -n websocket-example \
    create secret docker-registry \
    github-ghcr \
    --docker-server=ghcr.io \
    --docker-username=USERNAME \
    --docker-password=PASSWORD\
    --docker-email=EMAIL
