#!/bin/bash

kubectl delete secret nginx-server-certs nginx-ca-certs -n mesh-external
kubectl delete secret client-credential -n istio-system
kubectl delete configmap nginx-configmap -n mesh-external
kubectl delete service my-nginx -n mesh-external
kubectl delete deployment my-nginx -n mesh-external
kubectl delete namespace mesh-external
kubectl delete gateway istio-egressgateway
kubectl delete virtualservice direct-nginx-through-egress-gateway
kubectl delete destinationrule -n istio-system originate-mtls-for-nginx
kubectl delete destinationrule egressgateway-for-nginx


kubectl delete deployment task3-service-deployment
kubectl delete vs task3-service-ingress
kubectl delete svc task3-service-cip
kubectl delete gateway task3-service-gateway
kubectl label namespace default istio-injection=disabled

cd istio-1.17.2
export PATH=$PWD/bin:$PATH
istioctl manifest generate --set profile=demo | kubectl delete -f -
cd ..
rm -fr istio-1.17.2

rm example.com.crt example.com.key my-nginx.mesh-external.svc.cluster.local.crt my-nginx.mesh-external.svc.cluster.local.key my-nginx.mesh-external.svc.cluster.local.csr client.example.com.crt client.example.com.csr client.example.com.key
