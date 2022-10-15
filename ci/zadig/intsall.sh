#!/bin/sh

# https://docs.koderover.com/zadig/v1.15.0/install/overview/


helm repo add koderover-chart https://koderover.tencentcloudcr.com/chartrepo/chart

helm repo update

kubectl create ns zadig

export NAMESPACE=zadig

export DOMAIN=zadig.github.com

helm upgrade --install zadig koderover-chart/zadig --create-namespace --namespace ${NAMESPACE} --version=1.15.0 --set endpoint.FQDN=${DOMAIN} \
    --set global.extensions.extAuth.extauthzServerRef.namespace=${NAMESPACE} \
    --set "dex.config.staticClients[0].redirectURIs[0]=http://${DOMAIN}/api/v1/callback,dex.config.staticClients[0].id=zadig,dex.config.staticClients[0].name=zadig,dex.config.staticClients[0].secret=ZXhhbXBsZS1hcHAtc2VjcmV0"

helm upgrade --install --create-namespace -n zadig
--set global.extensions.extAuth.extauthzServerRef.namespace=zadig
--set endpoint.type=FQDN --set endpoint.FQDN=zadig.github.com
--set dex.fullnameOverride=zadig-zadig-dex
--set dex.config.issuer=http://zadig-zadig-dex:5556/dex
--set "dex.config.staticClients[0].redirectURIs[0]=http://zadig.github.com/api/v1/callback,dex.config.staticClients[0].id=zadig,dex.config.staticClients[0].name=zadig,dex.config.staticClients[0].secret=ZXhhbXBsZS1hcHAtc2VjcmV0"
--set init.adminPassword=zadig
--set init.adminEmail=lalifeier@gmail.com
--set tags.mysql=true --set mysql.persistence.pv=true --set mysql.primary.persistence.size=20Gi
--set tags.mongodb=true --set mongodb.persistence.pv=true --set mongodb.persistence.size=20Gi
--set tags.minio=true --set minio.persistence.pv=true  --set minio.persistence.size=20Gi
--set tags.ingressController=true --set ingress-nginx.controller.service.type=NodePort
--version=1.15.0 zadig-zadig koderover-chart/zadig


# helm upgrade --install --create-namespace -n zadig
# --set global.extensions.extAuth.extauthzServerRef.namespace=zadig
# --set endpoint.type=FQDN
# --set endpoint.FQDN=zadig.github.com
# --set dex.fullnameOverride=zadig-zadig-dex
# --set dex.config.issuer=http://zadig-zadig-dex:5556/dex
# --set "dex.config.staticClients[0].redirectURIs[0]=http://zadig.github.com/api/v1/callback,dex.config.staticClients[0].id=zadig,dex.config.staticClients[0].name=zadig,dex.config.staticClients[0].secret=ZXhhbXBsZS1hcHAtc2VjcmV0"
# --set init.adminPassword=zadig
# --set init.adminEmail=lalifeier@gmail.com
# --set tags.mysql=false --set connections.mysql.host=mysql:3306 --set connections.mysql.auth.user=root --set connections.mysql.auth.password=zadig --set dex.config.storage.config.host=mysql --set dex.config.storage.config.port=3306 --set dex.config.storage.config.user=root --set dex.config.storage.config.password=zadig
# --set tags.mongodb=false --set connections.mongodb.connectionString=mongodb://root:zadig@mongodb:27017 --set mongodb.db=zadig
# --set tags.minio=true --set minio.persistence.pv=true --set minio.persistence.size=20Gi
# --set tags.ingressController=true --set ingress-nginx.controller.service.type=NodePort
# --version=1.15.0 zadig-zadig koderover-chart/zadig

# 卸载
helm list -n zadig # 获得 Zadig 的 release name
helm uninstall <release name> -n zadig
