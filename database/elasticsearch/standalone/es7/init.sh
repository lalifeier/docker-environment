
#!/bin/sh

export ELASTIC_VERSION = 7.17.6

docker-compose exec elasticsearch elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v${ELASTIC_VERSION}/elasticsearch-analysis-ik-${ELASTIC_VERSION}.zip

docker-compose restart elasticsearch
