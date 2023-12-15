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
    git clone https://github.com/yourusername/tf-eks-infrastructure.git
    ```

3. **Create and switch to a new branch (e.g., dev) on your local machine:**

    ```bash
    git checkout -b dev
    ```

4. **Navigate to the project directory:**

    ```bash
    cd terraform
    ```

5. **Make necessary changes in the `variables.tf` file for your dev environment:**
    - Update `clusterName` with your desired EKS cluster name.
    - Update `region` with your preferred AWS region.
    - Update `vpcName` with your desired vpc name.


6. **Also, make necessary changes in the ".github/workflows/terraform_apply.yaml" file:**


    ```yaml
    env:
      AWS_REGION: <your-preferred-aws-region>
      EKS_CLUSTER: <your-eks-cluster-name>
    ```



7. **Commit your changes:**

    ```bash
    git add variables.tf
    git commit -m "Update variables for dev environment"
    ```

8. **Push the changes to the dev branch on GitHub:**

    ```bash
    git push origin dev
    ```

9. **Create a Pull Request (PR) from the dev branch to the main branch in the GitHub repository. Ensure that the changes are reviewed and approved.**

    **Note: If needed, you can bypass the approval process by force merging the changes. To force merge, click on "Merge pull request" and select the "Allow force merge" option.**

10. **Once the PR is approved (or force merged), monitor the GitHub Actions workflow in your repository for the automated EKS cluster deployment.**

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
