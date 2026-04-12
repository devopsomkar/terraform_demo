#!/bin/bash
echo ECS_CLUSTER=${cluster_name} >> /etc/ecs/ecs.config
yum update -y
yum install -y docker
service docker start
chkconfig docker on
yum install -y aws-cli
service ecs start
chkconfig ecs on

# Dynatrace OneAgent for EC2 metrics
export DT_TOKEN="${dynatrace_token}"
curl -H "accept:application/json" -H "Authorization: Api-Token DT_TOKEN" \
 "https://${dynatrace_tenant}.live.dynatrace.com/api/v1/deployment/installer/unix" | bash -s -- --set-infra-only
