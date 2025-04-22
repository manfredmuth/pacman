#!/usr/bin/bash

# Standard deployment
oc new-project pacman
oc apply -f pacman-deployment.yaml -n pacman
oc apply -f pacman-service.yaml -n pacman
oc apply -f pacman-route.yaml -n pacman # optional, for external access

