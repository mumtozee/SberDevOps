#!/bin/bash

curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.17.2 sh -

cd istio-1.17.2
export PATH=$PWD/bin:$PATH
cd ..

istioctl manifest apply --set profile=demo -y
istioctl install --set profile=demo --set meshConfig.outboundTrafficPolicy.mode=REGISTRY_ONLY -y
kubectl label namespace default istio-injection=enabled

# create service to query external mTLS service
kubectl apply -f task3_service/task3_deployment.yml
kubectl apply -f ingress/gateway.yml -f ingress/virtual_service.yml

# create all necessary sertificates
./create_ca.sh

# create NGINX service in another namespace and make it support only mTLS traffic
kubectl create namespace mesh-external
kubectl create -n mesh-external secret tls nginx-server-certs --key my-nginx.mesh-external.svc.cluster.local.key --cert my-nginx.mesh-external.svc.cluster.local.crt
kubectl create -n mesh-external secret generic nginx-ca-certs --from-file=example.com.crt

cd nginx_service
kubectl create configmap nginx-configmap -n mesh-external --from-file=nginx.conf=nginx.conf
kubectl apply -f service.yml
cd ..

kubectl create secret -n istio-system generic client-credential --from-file=tls.key=client.example.com.key \
  --from-file=tls.crt=client.example.com.crt --from-file=ca.crt=example.com.crt

# create egress gateway
kubectl apply -f egress/gateway.yml -f egress/virtual_service.yml 
kubectl apply -n istio-system -f egress/destination_rule.yml
minikube tunnel
