#!/bin/bash

# download ISTIO
# curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.17.2 sh -

# # export path to bin
# cd istio-1.17.2
# export PATH=$PWD/bin:$PATH

istioctl manifest apply --set profile=demo -y

istioctl install --set profile=demo --set meshConfig.outboundTrafficPolicy.mode=REGISTRY_ONLY -y

kubectl label namespace default istio-injection=enabled

kubectl apply -f random_activity_service/random_activity_depl.yml

kubectl apply -f ingress/gateway.yml -f ingress/virtual_service.yml

kubectl apply -f egress/gateway.yml -f egress/virtual_service.yml -f egress/service_entry.yml

kubectl apply -f nginx_service/service.yml -f nginx_service/configmap/configmap.yml

minikube tunnel