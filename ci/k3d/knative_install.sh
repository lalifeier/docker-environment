#!/bin/sh

# Knative
# https://knative.dev/docs/install/yaml-install/serving/install-serving-with-yaml

export KNATIVE_VERSION=1.8.0

# Install the Knative Serving component
# Install the required custom resources by running the command
kubectl apply -f https://github.com/knative/serving/releases/download/knative-v$KNATIVE_VERSION/serving-crds.yaml
# Install the core components of Knative Serving by running the command
kubectl apply -f https://github.com/knative/serving/releases/download/knative-v$KNATIVE_VERSION/serving-core.yaml

# Install a networking layer
# Install a properly configured Istio by following the Advanced Istio installation instructions or by running the command
kubectl apply -f https://github.com/knative/net-istio/releases/download/knative-v$KNATIVE_VERSION/istio.yaml
# Install the Knative Istio controller by running the command
kubectl apply -f https://github.com/knative/net-istio/releases/download/knative-v$KNATIVE_VERSION/net-istio.yaml
# Fetch the External IP address or CNAME by running the command
# kubectl --namespace istio-system get service istio-ingressgateway

# Verify the installation
# kubectl get pods -n knative-serving

# Configure DNS
kubectl apply -f https://github.com/knative/serving/releases/download/knative-v$KNATIVE_VERSION/serving-default-domain.yaml


# kubectl get ksvc -A
