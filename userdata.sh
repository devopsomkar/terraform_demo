#!/bin/bash
yum update -y
yum install -y docker aws-cli
systemctl enable docker
systemctl start docker
# Wait Docker ready
until docker info > /dev/null 2>&1; do
  echo "Waiting Docker..."
  sleep 5
done
echo ECS_CLUSTER=${cluster_name} >> /etc/ecs/ecs.config
systemctl enable ecs
systemctl start ecs
# Wait ECS agent
until curl -s http://localhost:51678/v1/metadata | grep -q '"Cluster"'; do
  echo "Waiting ECS agent..."
  sleep 10
done
# Dynatrace (fixed header)
curl -H "Authorization: Api-Token ${dynatrace_token}" \
  "https://${dynatrace_tenant}.live.dynatrace.com/api/v1/deployment/installer/unix" | bash -s -- --set-infra-only
