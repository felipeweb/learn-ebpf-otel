#!/bin/sh
set -o errexit

# Nome e porta do registro local
reg_name='kind-registry'
reg_port='5001'

# Cria o contêiner do registro a menos que já exista
if [ "$(docker inspect -f '{{.State.Running}}' "${reg_name}" 2>/dev/null || true)" != 'true' ]; then
  docker run \
    -d --restart=always -p "127.0.0.1:${reg_port}:5000" --name "${reg_name}" \
    registry:2
fi

# Cria um cluster com o registro local habilitado no containerd
kind create cluster --name "${CLUSTER_NAME}" --config kind_cluster.yaml

# Conecta o registro à rede do cluster, se ainda não estiver conectado
if [ "$(docker inspect -f='{{json .NetworkSettings.Networks.kind}}' "${reg_name}")" = 'null' ]; then
  docker network connect "kind" "${reg_name}"
fi

# Documenta o registro local
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: local-registry-hosting
  namespace: kube-public
data:
  localRegistryHosting.v1: |
    host: "localhost:${reg_port}"
    help: "https://kind.sigs.k8s.io/docs/user/local-registry/"
EOF
