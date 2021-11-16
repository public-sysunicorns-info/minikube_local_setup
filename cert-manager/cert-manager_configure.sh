#!/usr/bin/env bash

# Extract mkcert CA paths
ca_root_dir_path=$(mkcert -CAROOT)
ca_root_crt_path=${ca_root_dir_path}/rootCA.pem
ca_root_key_path=${ca_root_dir_path}/rootCA-key.pem

# Create the secret to store the CA and key
kubectl -n cert-manager create secret generic mkcert-ca \
    --save-config --dry-run=client \
    --from-file=tls.crt="${ca_root_crt_path}" --from-file=tls.key="${ca_root_key_path}" \
    -o yaml |
kubectl apply -f -

# Create the Cluster Issuer to be use after for resources
kubectl apply \
    -f ./specs/mkcert_cluster-issuer.yaml
