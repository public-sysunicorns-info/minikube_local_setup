#!/usr/bin/env bash

# minikube config set driver virtualbox 
# minikube config set driver hyperkit
# minikube config set driver hyperv

minikube config set cpus 4
minikube config set memory 8112

minikube start

minikube addons enable ingress
minikube addons enable ingress-dns
minikube addons enable metallb
minikube addons enable metrics-server