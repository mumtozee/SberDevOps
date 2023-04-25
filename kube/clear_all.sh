#!/bin/bash

kubectl delete deployment random-activity-service-deployment nginx-service-deployment
kubectl delete se boredapi-service-entry
kubectl delete vs boredapi-through-egress-gateway random-activity-service-ingress
kubectl delete cm nginx-service-cm random-activity-service-cm
kubectl delete svc random-activity-service-cip nginx-service-cip
kubectl delete gateway boredapi-egressgateway random-activity-service-gateway
kubectl delete destinationrule egressgateway-for-boredapi
kubectl label namespace default istio-injection=disabled

# cd istio-1.17.2
# export PATH=$PWD/bin:$PATH
istioctl manifest generate --set profile=demo | kubectl delete -f -
# cd ..

# ../docker/clear-image.sh
# rm -fr istio-1.17.2