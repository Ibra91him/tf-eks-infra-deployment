# Terraform EKS Infrastructure Deployment

## Overview

This project automates the deployment of an Amazon EKS (Elastic Kubernetes Service) cluster using Terraform and GitHub Actions. The setup includes a control plane and two worker nodes to facilitate a scalable and resilient Kubernetes environment.

## Features

- Infrastructure as Code (IaC) with Terraform for consistent and repeatable cluster deployment.
- GitHub Actions workflows for automated EKS cluster provisioning and configuration.
- Scalable architecture with a control plane and two worker nodes for optimal performance.

## Prerequisites

Ensure you have the following prerequisites before deploying the EKS cluster:

- AWS account with appropriate permissions.
- AWS CLI installed and configured with the necessary access rights.
- Terraform installed on your local machine.
- GitHub repository configured with appropriate secrets for AWS access.

### GitHub Secrets Configuration

1. **Create AWS Access Key:**
    - Generate an AWS access key with the necessary permissions for Terraform.
    - Configure the AWS CLI on your local machine using `aws configure` with the generated access key.

2. **Store AWS Secrets in GitHub:**
    - In your GitHub repository, navigate to "Settings" > "Secrets" > "New repository secret."
    - Add the following secrets:
        - `AWS_ACCESS_KEY_ID`: Your AWS access key ID.
        - `AWS_SECRET_ACCESS_KEY`: Your AWS secret access key.
        - `BUCKET_TF_STATE`: The name of the S3 bucket created for Terraform state.

## Deployment Steps

1.  **Fork this repository to you Github account**
2.  **Clone this repository to your local machine:**

    ```bash
    git clone https://github.com/yourusername/tf-eks-infra-deployment.git
    ```

3.  **Switch to the "dev" branch:**
    
     ``` bash
     git checkout dev
     ```

6. **Navigate to the project directory:**

    ```bash
    cd terraform
    ```

7. **Make necessary changes in the `variables.tf` file for your dev environment:**
    - Update `clusterName` with your desired EKS cluster name.
    - Update `region` with your preferred AWS region.
    - Update `vpcName` with your desired vpc name.


8. **Also, make necessary changes in the ".github/workflows/terraform_apply.yaml" file:**


    ```yaml
    env:
      AWS_REGION: <your-preferred-aws-region>
      EKS_CLUSTER: <your-eks-cluster-name>
    ```

9. **Commit your changes:**

    ```bash
    git add variables.tf
    git commit -m "Update variables for dev environment"
    ```

10. **Push the changes to the dev branch on GitHub:**

    ```bash
    git push origin dev
    ```
Note: the workflow will trigger on pushing to the dev branch as specified in the terrafrom_apply.yaml file. 


11. **In your GitHub repository, navigate to the "Actions" tab and you should see that the "Infra Deployment - EKS" has triggered. "It will only run a terraform plan at this point"

    **Note: review the plan to make sure everything looks good**

12. **Go back to your terminal and run switch back to the main branch, and run the following commands to merge your dev branch on main**
    
    ```bash
    git checkout main
    git merge dev
    git push origin main
    ```
14. **In your GitHub repository, navigate to the "Actions" tab and you should see that the "Infra Deployment - EKS" has triggered. "The terraform apply stage is going to be applied this time around", monitor the output and you can also check your aws console**

## Accessing the EKS Cluster

After a successful deployment, you can access the EKS cluster using the following steps:

1. **Configure kubectl with the generated kubeconfig file:**

    ```bash
    aws eks --region <region> update-kubeconfig --name <cluster-name>
    ```

2. **Use kubectl to interact with your EKS cluster:**

    ```bash
    kubectl get nodes
    ```

## Cleanup

To avoid incurring unnecessary costs, use the following GitHub Actions workflow to destroy the EKS cluster infrastructure:

1. **Navigate to the ".github/workflows" directory:**

    ```bash
    cd .github/workflows
    ```

2. **Open the "terraform_destroy.yaml" file in a text editor:**

    ```bash
    code terraform_destroy.yaml
    ```

3. **Update the following variables in the workflow file:**

    - `AWS_REGION`: Set your preferred AWS region.
    - `EKS_CLUSTER`: Set your EKS cluster name.

4. **Commit and push the changes to your repository.**

5. **In your GitHub repository, navigate to the "Actions" tab and select the "Infra Destroy - EKS" workflow.**

6. **Click on "Run workflow" and confirm the workflow execution.**

Monitor the GitHub Actions workflow for the automated destruction of the EKS cluster.
