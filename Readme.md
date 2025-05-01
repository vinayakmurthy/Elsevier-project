
Terraform EC2 Web Server with Tooplate HTML Template

This project provisions an EC2 instance on AWS using Terraform, installs an Apache2 web server, and hosts a static website using a Tooplate HTML template.

Table of Contents
1. Project Structure
2. Prerequisites
3. AWS Setup
4. Deployment Instructions
5. Teardown

----------------------------------------------------------------------

Project Structure

terraform-ec2-webserver/
├── Jenkins/
│   ├── scripts/
│   └── ssh-keys/
│   ├── backend.tf
│   ├── key-pair.tf
│   ├── main.tf
│   ├── output.tf
│   └── securitygroup.tf
├── terraform-codes/
│   ├── scripts/
│   └── ssh-key/
│   ├── aws_keypair.tf
│   ├── backend.tf
│   ├── instances.tf
│   ├── output.tf
│   ├── providers.tf
│   ├── s3_bucket.tf
│   ├── security.groups.tf
│   └── variables.tf
├── Jenkinsfile
└── Readme.md

- Jenkins: Contains the Jenkins-related scripts and configuration for automating deployment tasks.
- terraform-codes: Contains the core Terraform configurations for provisioning AWS infrastructure (e.g., EC2 instance, security groups, and S3 bucket).
- Jenkinsfile: The pipeline file for Jenkins automation.
- Readme.md: This documentation.

----------------------------------------------------------------------

**Prerequisites**

Before starting, ensure you have the following tools installed:

- Terraform: For provisioning infrastructure.
- AWS CLI: For interacting with AWS from the command line.
- Git: For version control.
- AWS account: Create an IAM user with the necessary permissions (EC2, S3, etc.).
- SSH keys: Generate an SSH key pair for connecting to the EC2 instance.

 **Using Remote Backend for State Management**

If you want to use an S3 bucket for storing the Terraform state file remotely, you can configure it by following these steps:

1. First, create the S3 bucket (using the `s3_bucket.tf` file or manually in the AWS Console).
2. Uncomment the `backend.tf` content in the `terraform-codes/backend.tf` file.
3. Run the following commands:
   ```bash
   terraform init
   terraform apply

----------------------------------------------------------------------

**AWS Setup**

1. Configure AWS CLI:
   aws configure
   Provide your AWS access keys and set your default region.

2. Generate SSH Key Pair:
   ssh-keygen
   - Store the keys at: elsevier-project/terraform-codes/ssh-key/id_ed25519, elsevier-project/jenkins/ssh-key/id_ed25519

----------------------------------------------------------------------

**Deployment Instructions**

1. Clone the repository:
   git clone https://github.com/vinayakmurthy/elsevier-project.git
   cd terraform-codes

2. Initialize Terraform:
   terraform init

3. Validate configuration:
   terraform validate

4. Preview infrastructure changes:
   terraform plan

5. Apply infrastructure:
   terraform apply

6. Access the website:
   After applying the configuration, Terraform will output the public IP/DNS of the EC2 instance. Open it in your browser to view the hosted Tooplate HTML template.

----------------------------------------------------------------------

**Example Output**

Upon successful deployment, you’ll receive output similar to:

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

public_ip = "http://<public-ip>"

Open the given public_ip in your browser to access the hosted website.

----------------------------------------------------------------------

**Teardown**

To destroy the infrastructure and prevent AWS charges:
terraform destroy

This command will tear down all the resources you’ve provisioned (e.g., EC2 instance, security groups).

--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------

  **Automated Deployment with Jenkins**

This section outlines how to automate the above steps using Jenkins.
As per the request to use GitHub Actions: since I am more comfortable and experienced with Jenkins, I opted to use Jenkins for this automation. Below is my approach to implementing infrastructure deployment using a Jenkins pipeline.

1. Start by provisioning a Jenkins EC2 instance using the configurations in the Jenkins folder:
   cd Jenkins
   terraform init
   terraform apply

2. Once the instance is provisioned, Terraform will output the public IP with a message like:
   jenkins-pubIP = "Access the Jenkins website at <public-ip>:8080"

3. Access Jenkins in your browser using the given IP on port 8080 and complete the initial setup. During this setup, choose "Install suggested plugins" when prompted.

4. After setup, create the required credentials in Jenkins:
   - AWS Access Key ID and Secret Access Key (for Terraform AWS provider)
   - SSH Private Key for accessing EC2 (Note: Since the private key is not pushed to GitHub, upload it securely into Jenkins credentials)

5. Create a new Pipeline job in Jenkins:
   - Click on "New Item" → Enter a name → Choose "Pipeline" → Click OK
   - Under the Pipeline section, choose "Pipeline script from SCM"
   - SCM: Git
   - Repository URL: https://github.com/vinayakmurthy/elsevier-project.git
   - Branch: main
   - Script Path: Jenkinsfile

6. Save the job and run "Build Now". Jenkins will automatically:
   - Pull the latest Terraform code from GitHub
   - Run `terraform init`, `validate`, `plan`, and `apply` inside the pipeline
   - Provision an EC2 instance, install Apache2, and deploy the Tooplate static HTML website

7. On successful execution, you will see the public IP of the newly created EC2 instance in the output. Open it in your browser at port 80 to see the hosted website.

Note: The Jenkins setup itself also requires some manual configuration on first launch (admin password, suggested plugins). These are standard and only required once.

Teardown
To destroy all provisioned resources and avoid incurring AWS charges, either run the following manually or through Jenkins:

terraform destroy
This will remove the EC2 instance, security groups, and other AWS resources provisioned by Terraform.

--------------------------------------------------------------------------------------------------------------------------------------------

