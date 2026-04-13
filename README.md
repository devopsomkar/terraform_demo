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
