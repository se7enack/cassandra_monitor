#!/bin/bash

export INGRESS_CONTROLLER_VERSION="4.2.0"
export INGRESS_CONTROLLER_IP="10.10.10.200"
NAMESPACE="cassandra-mon"

printf "\ninstall ingress\n"
helm install $NAMESPACE ingress-nginx/ingress-nginx --version $INGRESS_CONTROLLER_VERSION \
    -f internal-ingress-options.yaml \
    --atomic \
    --namespace "$NAMESPACE" \
    --set controller.ingressClassResource.name="$NAMESPACE" \
    --set controller.scope.namespace="$NAMESPACE" \
    --set controller.scope.enabled="true" \
    --set controller.ingressClass=nginx \
    --set controller.service.loadBalancerIP=$INGRESS_CONTROLLER_IP \
    --set rbac.create=true \
    --set-string controller.config.server-tokens=false \
    --set-string controller.config.use-forwarded-headers=true \
    --set controller.kind="Deployment" \
    --set controller.resources.limits."memory"=2G \
    --set controller.resources.limits."cpu"=1 \
    --set controller.resources.requests."memory"=1M \
    --set controller.resources.requests."cpu"=.01 \
    --set controller.config.hide-headers="Server" \
    --set controller.service.externalTrafficPolicy=Local \
    --set tcp.3000="$NAMESPACE/$NAMESPACE:3000"
            


            
