pipeline {
    agent any

    environment {
        private_key_ssh = credentials("id_ed25519")
        AWS_ACCESS_KEY_ID = credentials("AWS_ACCESS_KEY_ID")
        AWS_SECRET_ACCESS_KEY = credentials("AWS_SECRET_ACCESS_KEY")
        AWS_REGION = 'us-east-1'
    }

    stages {
        stage("Pull the code") {
            steps {
                git branch: 'main', url: 'https://github.com/vinayakmurthy/Elsevier.git'
            }
        }

        stage("Initialize the provider") {
            steps {
                sh """
                    cd Terraform-codes
                    terraform init
                """
            }
        }

        stage("Terraform fmt and validate") {
            steps {
                sh """
                    cd Terraform-codes
                    terraform fmt
                    terraform plan -out=plan.out   # Save the plan to a file to use later
                """
            }
        }

        stage("Apply the tf plan") {
            steps {
                sh """
                    cd Terraform-codes
                    echo "$private_key_ssh" > ./Terraform-codes/ssh-keys/id_ed25519
                    chmod 600 ./ssh-keys/id_ed25519

                    # Set AWS credentials for Terraform to use
                    export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                    export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                    export AWS_REGION=$AWS_REGION

                    # Apply the plan without requiring manual approval
                    terraform apply -auto-approve plan.out  # Use the saved plan file
                """
            }
        }
    }
}
