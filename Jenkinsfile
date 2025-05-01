pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials("AWS_ACCESS_KEY_ID")
        AWS_SECRET_ACCESS_KEY = credentials("AWS_SECRET_ACCESS_KEY")
        AWS_REGION = 'us-east-1'
    }

    stages {
        stage("Pull the code") {
            steps {
                git branch: 'main', url: 'https://github.com/vinayakmurthy/elsevier-project.git'
            }
        }

        stage("Prepare SSH Key") {
            steps {
                withCredentials([file(credentialsId: 'id_ed25519', variable: 'SSH_KEY_PATH')]) {
                    sh """
                        cd terraform-codes
                        cp \$SSH_KEY_PATH ./ssh-key/id_ed25519
                        chmod 600 ./ssh-key/id_ed25519 
                        ls -l ./ssh-key/id_ed25519
                    """
                }
            }
        }

        stage("Initialize the provider") {
            steps {
                sh """
                    cd terraform-codes
                    terraform init
                """
            }
        }

        stage("Terraform fmt and validate") {
            steps {
                sh """
                    cd terraform-codes
                    terraform fmt
                    terraform plan
                """
            }
        }

        stage("Apply the tf plan") {
            steps {
                sh """
                    cd terraform-codes
                    export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                    export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                    export AWS_REGION=$AWS_REGION

                    terraform apply -auto-approve  # Use the saved plan file
                """
            }
        }
    }
}
