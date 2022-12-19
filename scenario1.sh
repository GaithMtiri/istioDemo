#!/bin/bash         

sudo su
cd istio-1.16.1
export PATH=$PWD/bin:$PATH
istioctl install --set profile=demo -y
kubectl label namespace default istio-injection=enabled

kubectl apply -f samples/bookinfo/networking/virtual-service-all-v1.yaml
kubectl apply -f samples/bookinfo/networking/virtual-service-reviews-test-v2.yaml

kubectl apply -f samples/bookinfo/networking/virtual-service-ratings-test-abort.yaml
