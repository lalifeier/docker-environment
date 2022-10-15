#!/bin/sh

wget https://dlcdn.apache.org/skywalking/java-agent/8.12.0/apache-skywalking-java-agent-8.12.0.tgz
tar -zxvf apache-skywalking-java-agent-8.12.0.tgz
mkdir -p skywalking/agent/plugins
cp skywalking-agent/skywalking-agent.jar skywalking/agent
cp skywalking-agent/optional-plugins/apm-spring-cloud-gateway-2.1.x-plugin-8.12.0.jar skywalking/agent/plugins
rm -rf skywalking-agent
rm -rf apache-skywalking-java-agent-8.12.0.tgz
