# Manage Confluent Cloud Flink with Terraform and GitOps

[![CI/CD Pipeline](https://github.com/rosingh22/cc-flink-tf-git-actions-public/actions/workflows/deploy.yml/badge.svg)](https://github.com/rosingh22/cc-flink-tf-git-actions-public/actions/workflows/deploy.yml)

This repository provides a complete GitOps workflow for deploying and managing Flink SQL statements on Confluent Cloud using Terraform and GitHub Actions. This approach treats your stream processing logic as code, enabling version control, automated deployments, and a full CI/CD pipeline.

---

## Core Technologies

* 🚀 **Terraform**: For defining the Flink statement as Infrastructure as Code.
* ☁️ **Confluent Cloud**: The managed Apache Kafka and Flink platform.
* 🐙 **GitHub**: For version control of our Terraform and SQL code.
* 🤖 **GitHub Actions**: For automating the CI/CD pipeline (`plan` and `apply`).

---

## The GitOps Workflow

This project follows a standard GitOps pattern to ensure safe and automated deployments.



1.  **Develop**: A developer modifies a Flink SQL statement in the `/sql` directory and pushes the changes to a new branch.
2.  **Pull Request**: The developer opens a pull request to merge the changes into the `main` branch.
3.  **Plan**: This automatically triggers the `pr-plan.yml` GitHub Action, which runs `terraform plan`. The output of the plan is posted as a comment on the pull request for review. Branch protection rules can be set to require this check to pass.
4.  **Review & Merge**: The team reviews the proposed changes in the pull request. If approved, the PR is merged.
5.  **Apply**: Merging to `main` automatically triggers the `deploy.yml` GitHub Action, which runs `terraform apply`, deploying the updated Flink statement to Confluent Cloud with zero downtime.

---

## Prerequisites

Before you begin, ensure you have the following:

* A [Confluent Cloud](https://confluent.cloud/) account.
* A Flink Compute Pool created in your target Confluent Cloud environment.
* Terraform installed locally (for initial setup or testing).

---

## 🛠️ Setup and Configuration

Follow these steps to configure the repository for your own Confluent Cloud environment.

### 1. Configure Confluent Cloud Resources

You will need the following information from your Confluent Cloud account:
* **Confluent Cloud API Key & Secret**: For authenticating Terraform.
* **Flink API Key & Secret**: Scoped to your Flink Compute Pool.
* **Environment ID**: The ID of your Confluent Cloud environment (e.g., `env-xxxxx`).
* **Flink Compute Pool ID**: The ID of your compute pool (e.g., `lfcp-xxxxx`).
* **Principal ID**: The ID of the Service Account or User Account (`sa-xxxxx` or `u-xxxxx`) that will run the Flink statement.

### 2. Configure GitHub Secrets

This project uses GitHub Actions secrets to securely store your credentials. **Do not hardcode credentials in your Terraform files.**

In your GitHub repository, go to **Settings > Secrets and variables > Actions** and create the following secrets:

```
CONFLUENT_CLOUD_API_KEY
CONFLUENT_CLOUD_API_SECRET
CONFLUENT_ENV_ID
CONFLUENT_FLINK_POOL_ID
CONFLUENT_FLINK_API_KEY
CONFLUENT_FLINK_API_SECRET
CONFLUENT_FLINK_PRINCIPAL_ID
```

---

## 🚀 Usage

To deploy or update a Flink statement, follow the GitOps workflow:

1.  **Create a Branch**:
    ```bash
    git checkout -b update-limit-query
    ```
2.  **Modify the SQL**:
    Edit the `sql/stock_select.sql` file with your desired changes.
3.  **Commit and Push**:
    ```bash
    git add .
    git commit -m "feat: Update Flink query to limit by 20"
    git push origin update-limit-query
    ```
4.  **Open a Pull Request**:
    In GitHub, open a pull request from your new branch to `main`. The `pr-plan.yml` workflow will automatically run and post the `terraform plan` output as a comment.
5.  **Merge the Pull Request**:
    After reviewing the plan and getting approvals, merge the PR. This will trigger the `deploy.yml` workflow to apply the changes to Confluent Cloud.

---

## 📁 Project Structure

```
.
├── .github/workflows/      # GitHub Actions CI/CD workflows
│   ├── pr-plan.yml         # Runs `terraform plan` on pull requests
│   └── deploy.yml          # Runs `terraform apply` on merge to main
├── sql/
│   └── stock_select.sql    # Your Flink SQL logic lives here
├── main.tf                 # Main Terraform file defining the Flink resource
├── variables.tf            # Terraform variable definitions
└── README.md               # This file
```
