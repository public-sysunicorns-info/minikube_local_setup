#!/usr/bin/env bash

minikube addons enable ingress
minikube addons enable ingress-dns
minikube addons enable metallb
minikube addons enable metrics-server

minikube config set cpus 4
minikube config set memory 8112

minikube start
