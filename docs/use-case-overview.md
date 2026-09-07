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
| DNS | Amazon Route 53 |
| Email | Amazon Simple Email Service (SES) |
| Secrets | AWS Secrets Manager |
| Identity | AWS IAM |
| Storage | Amazon S3 |
| Application | Angular (frontend), a backend service (Node.js/Spring Boot-style) |

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

## Business Case

In a fast-paced business environment, delivering applications quickly and securely matters. A traditional, manual deployment process tends to produce slow releases, manual errors, and higher operational costs. DevOps addresses this directly: by automating the build, test, and deployment lifecycle, it enables rapid, reliable, and continuous delivery.

## Business Benefits

- **Faster time to market** — automated pipelines remove manual handoffs between infra and application changes.
- **Improved customer experience** — rapid deployments mean quicker access to new features and bug fixes.
- **Increased efficiency and cost savings** — automation reduces manual errors, optimizes resource utilization, and lowers operational overhead.
- **Enhanced security and compliance** — AWS's built-in security controls help meet industry standards without extra manual effort.
- **Scalability and flexibility** — ECS and DynamoDB scale resources dynamically as demand changes.

DevOps here means more than CI/CD — it also means continuous monitoring, implemented through CloudWatch, giving a single dashboard view across all resources in the environment.

## Use Case

This is a 3-tier architecture:

- **Presentation tier** — the Application Load Balancer and the frontend application.
- **Logic tier** — the backend application.
- **Data tier** — DynamoDB, fully managed and handling storage for both application tables.

## Architecture Walkthrough

Docker packages the application and its dependencies into containers. Amazon ECS runs those containers on a cluster of EC2 instances, sized and scaled automatically via Auto Scaling Groups. Terraform defines every piece of that infrastructure — EC2 instances, load balancers, security groups — as code, so the whole environment is reproducible and consistent across `dev` and `prod`.

On the delivery side: AWS CodeBuild builds the container image and pushes it to Amazon ECR. An ECS task definition specifies exactly how each container should run — image, environment variables, port mappings. Source code lives in AWS CodeCommit, and CodeBuild handles build and test before deployment. Amazon Route 53 manages the domain name and DNS, routing traffic to the load balancer.

The result is a microservices-based, highly available, highly scalable application, with CloudWatch, IAM, Secrets Manager, S3, and SNS supporting it underneath.

> One thing that stood out while building this: Terraform as Infrastructure as Code was a genuine turning point in how the environment was managed — a single, version-controlled configuration could stand up (or tear down) the entire environment consistently, rather than relying on manual console changes that drift between environments over time.

## What This Demonstrates

- Designing a two-pipeline delivery model that separates infrastructure changes from application changes, so each can be iterated on and deployed independently.
- Wiring Terraform-managed infrastructure (VPC, ALB, ASG, ECS, ECR, DynamoDB) into a fully automated CI/CD flow triggered by CodeCommit pushes.
- Path-based ALB routing to serve a multi-service application (frontend + backend) from a single load balancer.
- Environment-aware Terraform (`dev.tfvars` / `prod.tfvars`) driving the same configuration across multiple environments via a single `environment` variable.

## Reflection

Throughout the internship, this project meant hands-on experience across the full delivery lifecycle — setting up CI/CD pipelines with AWS CodePipeline, writing and iterating on Terraform configurations, and seeing a fully automated path from a code push to a running, load-balanced application. Each piece of it — the infra pipeline, the application pipeline, the monitoring layer — built toward the same goal: making deployments fast, repeatable, and low-risk instead of manual and error-prone.

---
*Cloud Internship — AWS DevOps*
