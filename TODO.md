# TODO: Add EC2 Capacity to ECS Cluster - Progress

## Steps:
- [x] 1. Create variables.tf with EC2 params
- [x] 2. Create outputs.tf
- [x] 3. Edit iam.tf to add EC2 instance role and profile
- [x] 4. Create ec2.tf with launch template, instance profile, ASG
- [x] 5. Edit ecs.tf to add capacity provider
- [x] 6. Edit service.tf to use capacity provider strategy
- [ ] 7. terraform fmt, validate, plan
- [ ] 8. terraform apply
- [x] All EC2/Dynatrace complete
- [x] Nginx image in task def
- [ ] terraform apply
- [ ] Curl nginx page

**All code edits complete!**

## Final Steps:
- [ ] 7. `terraform fmt && terraform validate`
- [ ] 8. `terraform plan -var="key_name=your-keypair-name"` (optional key)
- [ ] 9. `terraform apply`
- [ ] 10. Push Docker image to ECR repo.
- [ ] 11. Check AWS ECS console: EC2 instances joined to cluster, service running.

Your Terraform now provisions EC2 instances via ASG that auto-join the cluster via userdata, with capacity provider managing scaling.
