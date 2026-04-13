# Terraform ECS Refactor to Modules TODO

## Status: [ ] In Progress

### 1. [ ] Create modules directory structure
- modules/vpc/, iam/, ecr/, ec2/, ecs-core/, ecs-app/
- Each: main.tf, outputs.tf, variables.tf (where needed)

### 2. ✅ Move VPC code
- Copy vpc.tf → modules/vpc/main.tf
- Add outputs.tf (vpc_id, public_subnet_ids)
- Delete vpc.tf

### 3. ✅ Move IAM code
- iam.tf → modules/iam/main.tf
- outputs.tf (instance_profile_name, task_exec_role_arn)
- Delete iam.tf

### 4. [ ] Move ECR
- ecr.tf → modules/ecr/main.tf
- outputs.tf (repository_url)
- Delete ecr.tf

### 5. ✅ Move EC2/ASG
- ec2.tf → modules/ec2/main.tf
- Pass vpc_id, subnets, profile_name, cluster_name vars
- Delete ec2.tf

### 6. ✅ Move ECS Core
- ecs.tf → modules/ecs-core/main.tf  
- Pass asg_arn
- Delete ecs.tf

### 7. ✅ Move ECS App (Task + Service)
- taskdefination.tf + service.tf → modules/ecs-app/main.tf
- Pass cluster_id, cp_name, repo_url, exec_role_arn
- Delete both

### 8. ✅ Create root main.tf
- Call all modules with dependencies

### 9. ✅ Update root outputs.tf, variables.tf

### 10. ✅ Test
- terraform init
- terraform validate
- terraform plan (no changes)
- terraform apply (optional)

### 11. ✅ Git commit & PR
- Branch: blackboxai/refactor-modules

