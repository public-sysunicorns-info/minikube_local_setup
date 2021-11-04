#!/usr/bin/env bash

ca_root_dir_path=$(mkcert -CAROOT)
ca_root_crt_path=${ca_root_dir_path}/rootCA.pem
ca_root_key_path=${ca_root_dir_path}/rootCA-key.pem

kubectl -n cert-manager create secret generic mkcert-ca \
    --save-config --dry-run=client \
    --from-file=tls.crt="${ca_root_crt_path}" --from-file=tls.key="${ca_root_key_path}" \
    -o yaml |
kubectl apply -f -

kubectl apply \
    -f ./specs/mkcert_cluster-issuer.yaml
