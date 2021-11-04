#!/usr/bin/env bash

kubectl apply -f ./specs/ns.yaml
kubectl apply -f ./specs/deployment.yaml
kubectl apply -f ./specs/service.yaml
kubectl apply -f ./specs/ingress.yaml
