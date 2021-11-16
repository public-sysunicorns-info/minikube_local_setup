# Minikube
## 1. Setup
[Follow install example](https://minikube.sigs.k8s.io/docs/start/)
[For Windows and WSL, i recommand this post.](https://medium.com/@JockDaRock/minikube-on-windows-10-with-hyper-v-6ef0f4dc158c)

## 1.1. Minikube Addons and StartUp
``` bash
#!/usr/bin/env bash
#!/usr/bin/env bash

# Set your driver depending on sur OS

# MacOs or Linux
# minikube config set driver virtualbox 

# MacOS ( if virtualbox is not working )
# minikube config set driver hyperkit

# Windows and WSL 
# (you will use Powershell instead of bash for setuping minikube)
# minikube config set driver hyperv

# Set Hardware Resource of the VM of minikube
minikube config set cpus 4
minikube config set memory 8112

# Start Minikube
minikube start

# Setup Addons in minikube
minikube addons enable ingress
minikube addons enable ingress-dns
minikube addons enable metallb
minikube addons enable metrics-server

```

Usefull command:
``` bash
#!/usr/bin/env bash

# See the status of minikube
minikube status

# Put minikube in pause to save resources
minikube pause
# Remove pause mode
minikube unpause

# Stop totally the cluster
minikube stop
# ReStart the cluster ( need to verify if addons is also ok)
minikube start

```


## 1.2. Minikube Addons Ingress-DNS

This addons add the capabilities to forward dns query to minikube for specific root domain. In my case, i use *.minikube to force dns and route to minikube.
( All url for service in minikube need to end with .minikube )

[See documentation](https://minikube.sigs.k8s.io/docs/handbook/addons/ingress-dns/)

Example of /etc/resolver/minikube file:

```
domain minikube
nameserver 192.168.99.100
search_order 1
timeout 5
```
Replace the IP by the result of
``` bash
minikube ip
```
## 2. Cert-Manager
SSL in development is not anymore painless and contribute to have production like local env.
For that we will use two tools:
- mkcert: Create local Certificate Authority that you will trust locally
- cert-manager: Automaticly Generate Certificate for Kubernetes Resources
### 2.1 Mkcert (Dependencies)
[Follow Documentation for Installation](https://github.com/FiloSottile/mkcert)

For Windows and WSL, i recommand to install on linux, retrieve the CA and CA-Key. And Trust it after on windows side. The "mkcert install" will only auto-trust for the linux side.


### 2.2 Cert-Manager


``` bash
#!/usr/bin/env bash

#All Scripts are configure to be use in the directory
cd ./cert-manager

./cert-manager_install.sh

sleep 5

./cert-manager_configure.sh

cd ..

```
## 3. Github Container Registry
minikube need to have credentials to access to Github Container Registry

``` bash
#!/usr/bin/env bash

# Replace value:
# USERNAME: Github Username
# PASSWORD: Github Personnal Access Token
# EMAIL: Github Email

kubectl -n websocket-example \
    create secret docker-registry \
    github-ghcr \
    --docker-server=ghcr.io \
    --docker-username=USERNAME \
    --docker-password=PASSWORD\
    --docker-email=EMAIL

```

## 4. Test-service to validate installation

Deploy a test service with Simple Hello World
[Access to it](https://test-service.minikube)

``` bash
#!/usr/bin/env bash

cd ./test-service

./test-service_configure.sh

```
