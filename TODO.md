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

application flow

terraform apply
    ↓
EC2 starts → userdata: "Install Docker! Join cluster!"  ← YES, Docker installed here
    ↓
ECS Service: "Go run task on EC2!"
    ↓
EC2 Docker: pull nginx → start container → App on IP:80  ← YES, image pulled & deployed here



setup

c:/Users/owani/OneDrive - Deloitte (O365D)/Desktop/terraform ecs/
├── .gitignore
├── .terraform.lock.hcl
├── dynatrace.tf           ← NEW: Dynatrace config/policy/output
├── ec2.tf                 ← ASG/launch template/userdata
├── ecr.tf                 ← ECR repo
├── ecs.tf                 ← Cluster (capacity provider TBD)
├── iam.tf                 ← Roles/profiles (task + EC2)
├── outputs.tf             ← Cluster/service/ECR/ASG/Dynatrace
├── provider.tf            ← AWS ap-south-1 (creds fixed)
├── README.md
├── service.tf             ← ECS service
├── taskdefination.tf      ← Task def (your app)
├── TODO.md                ← Progress: All code done!
├── userdata.sh            ← ECS + Dynatrace install
├── variables.tf           ← EC2 + Dynatrace vars
├── terraform.tfvars       ← key_name + your Dynatrace token
└── vpc.tf                 ← Default subnets

