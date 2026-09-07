# Use Case Overview — Cloud Internship, AWS DevOps

*April 2023 – July 2023*

## The Use Case

> Create an integrated pipeline to deploy a 3-tier, container-based application on AWS.

The training project — internally referred to as **HCI AWS** — was a hands-on exercise in building a complete, self-service infrastructure delivery pipeline: an intern-written Terraform configuration, triggered automatically by a CodePipeline/CodeCommit/CodeBuild pipeline, provisioning a full 3-tier application environment on AWS, with a second pipeline handling the application layer (build, containerize, deploy).

## Tech Stack

| Category | Technology |
|---|---|
| Infrastructure as Code | Terraform |
| Database | Amazon DynamoDB |
| Continuous Delivery | AWS CodePipeline, CodeCommit, CodeBuild |
| Compute | Amazon Elastic Container Service (ECS), EC2 Auto Scaling |
| Container Registry | Amazon Elastic Container Registry (ECR) |
| Monitoring & Logging | Amazon CloudWatch |
| Messaging | Amazon Simple Notification Service (SNS) |
| Secrets | AWS Secrets Manager |
| Identity | AWS IAM |
| Application | Angular (frontend), Node.js/Spring Boot-style service (backend) |

## Two Pipelines

### Infra Pipeline
1. A change is made to the Terraform configuration and pushed to the **CodeCommit** infra repository.
2. **CodePipeline** detects the commit and triggers a new **CodeBuild** run.
3. CodeBuild installs Terraform, runs `terraform init`, `plan`, and `apply -auto-approve`.
4. AWS resources (VPC, subnets, ALB, ASG, ECS clusters, ECR repositories, DynamoDB tables) are created or updated.

### Application Pipeline
1. Updates are made to the application's **CodeCommit** repository (frontend or backend).
2. **CodePipeline** automatically triggers the corresponding **CodeBuild** project.
3. CodeBuild builds a Docker image and pushes it to **Elastic Container Registry**.
4. Once the image is available, CodePipeline triggers deployment to **ECS**.

## Infrastructure Summary

- A single VPC with 1 public subnet and 2 private subnets — one subnet grouping for ECS/EC2 compute, one for DynamoDB-adjacent resources.
- Full networking and security established: route tables, an Internet Gateway, a NAT Gateway, and security groups scoping traffic between the ALB and the application tier.
- DynamoDB tables, ECS clusters, Auto Scaling Groups, and task definitions created and wired up to the Application Load Balancer via path-based routing rules.
- The ALB's DNS name is used directly for testing — `/jiraportal/*` routes to the frontend target group, `/service/*` routes to the backend target group.

## Application Summary

- A Jira-style sprint/story-tracking web application, with an Angular frontend and a backend service, deployed as two separate ECS services behind the same Application Load Balancer.
- Application data is stored in two DynamoDB tables: `PlannedStoryPoints` (sprint and story-point tracking) and `UserDetails` (application user accounts).

## What This Demonstrates

- Designing a two-pipeline delivery model that separates infrastructure changes from application changes, so each can be iterated on and deployed independently.
- Wiring Terraform-managed infrastructure (VPC, ALB, ASG, ECS, ECR, DynamoDB) into a fully automated CI/CD flow triggered by CodeCommit pushes.
- Path-based ALB routing to serve a multi-service application (frontend + backend) from a single load balancer.
- Environment-aware Terraform (`dev.tfvars` / `prod.tfvars`) driving the same configuration across multiple environments via a single `environment` variable.

---
*Cloud Internship — AWS DevOps*
