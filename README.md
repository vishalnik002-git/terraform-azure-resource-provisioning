# 📦 Azure Resource Provisioning: Resource Groups & Storage Accounts

![Terraform Version](https://img.shields.io/badge/Terraform-1.5%2B-blue.svg?logo=terraform)
![Azure Provider](https://img.shields.io/badge/AzureRM-3.100%2B-0078D4.svg?logo=microsoft-azure)
![IaC](https://img.shields.io/badge/IaC-Resource%20Provisioning-623CE4.svg)
![Validation](https://img.shields.io/badge/Validation-Pass-success.svg)

> **Repository 02 of 08 in the Terraform + Microsoft Azure Professional Learning Series**

---

## 📌 Navigation
| ⏪ Previous Repository | 📚 Current Repository | ⏩ Next Repository |
| :--- | :---: | :--- |
| [← 01. terraform-azure-fundamentals](https://github.com/vishalnik002-git/terraform-azure-fundamentals) | **02. terraform-azure-resource-provisioning** | [03. terraform-azure-variables-and-data-types →](https://github.com/vishalnik002-git/terraform-azure-variables-and-data-types) |

---

## 📖 Project Overview

This repository demonstrates practical cloud resource provisioning in **Microsoft Azure** using **Terraform**. It focuses on two foundational Azure resources:
1. **Azure Resource Group** (`azurerm_resource_group`) - The logical container for Azure resources.
2. **Azure Storage Account** (`azurerm_storage_account`) - Highly scalable cloud object and blob storage.

It highlights how Terraform automatically determines creation order through **implicit dependencies**, ensuring dependent resources are provisioned in the correct sequence without manual intervention.

> ℹ️ **Learning Note**: This repository contains learning configurations and documentation. Automated validation checks verify HCL syntax without provisioning live Azure cloud resources.

---

## 🎯 Learning Objectives

By exploring this repository, you will learn:
1. How to define multiple related cloud resources in Terraform configuration.
2. Required properties for Azure Resource Groups: `name` and `location`.
3. Required properties for Azure Storage Accounts: `name`, `resource_group_name`, `location`, `account_tier`, and `account_replication_type`.
4. How **Resource Referencing** (`azurerm_resource_group.rg.name`) creates an **implicit dependency** graph.
5. Azure naming constraints for Storage Accounts (globally unique, 3-24 lowercase alphanumeric characters).
6. How to structure independent example directories for clear demonstrations.

---

## 🏗️ Resource Relationship & Dependency Graph

```
+-------------------------------------------------------------+
|                Implicit Dependency Flow                     |
+-------------------------------------------------------------+
                              |
       +---------------------------------------------+
       |   resource "azurerm_resource_group" "rg"    |
       |   - name: "rg-provisioning-dev"             |
       |   - location: "eastus"                      |
       +---------------------------------------------+
                              |
                     Reference (.name & .location)
                              |
                              v
       +---------------------------------------------+
       |   resource "azurerm_storage_account" "sa"   |
       |   - resource_group_name: rg.name            |
       |   - location: rg.location                   |
       |   - account_tier: "Standard"                |
       |   - account_replication_type: "LRS"         |
       +---------------------------------------------+
```

---

## 📂 Repository Structure

```
terraform-azure-resource-provisioning/
├── .github/
│   └── workflows/
│       └── validate.yml          # GitHub Actions validation pipeline
├── examples/
│   ├── 01-resource-group/        # Standalone Resource Group example
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── versions.tf
│   └── 02-storage-account-with-rg/ # Paired RG and Storage Account example
│       ├── main.tf
│       ├── outputs.tf
│       └── versions.tf
├── .gitignore                    # Git exclusion rules
├── main.tf                       # Primary RG and Storage Account definitions
├── outputs.tf                    # Declares output values (Storage endpoints, IDs)
├── providers.tf                  # AzureRM provider configuration
├── terraform.tfvars.example      # Example input parameters
├── variables.tf                  # Parameterized input variables
├── versions.tf                   # Terraform version constraint declarations
└── README.md                     # Comprehensive documentation
```

---

## 🧩 Technical Concepts

### 1. Azure Resource Group
An Azure Resource Group is a fundamental organizational container. In Terraform, it requires only two mandatory arguments:
```hcl
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}
```

### 2. Azure Storage Account Requirements
Every storage account requires five essential parameters:
1. `name`: Globally unique across all of Azure (3 to 24 characters, numbers and lowercase letters only, no hyphens or underscores).
2. `resource_group_name`: The parent Resource Group where the storage account resides.
3. `location`: The Azure region hosting the data.
4. `account_tier`: `Standard` (magnetic/cost-effective) or `Premium` (solid-state drives / high throughput).
5. `account_replication_type`: Redundancy strategy:
   - `LRS` (Locally Redundant Storage - 3 copies in single datacenter)
   - `GRS` (Geo-Redundant Storage - replicates to secondary paired region)
   - `ZRS` (Zone-Redundant Storage - replicated across three availability zones)

### 3. Implicit Dependency
When we assign:
```hcl
resource_group_name = azurerm_resource_group.rg.name
```
Terraform's Directed Acyclic Graph (DAG) parser identifies that `azurerm_storage_account.sa` cannot be created until `azurerm_resource_group.rg` is successfully provisioned. You do not need to add explicit `depends_on` when attribute references are present.

---

## 🛠️ Step-by-Step Getting Started Guide

### Prerequisites
- [Terraform CLI](https://developer.hashicorp.com/terraform/downloads) (v1.5.0+).

### 1. Format Code
```bash
terraform fmt
```

### 2. Initialize Working Directory
```bash
terraform init -backend=false
```

### 3. Validate Configuration
```bash
terraform validate
```

### 4. Review Plan (Educational Documentation)
```bash
terraform plan
```

### 5. Apply Changes (Educational Documentation)
```bash
terraform apply
```
> ⚠️ **IMPORTANT**: In production, `terraform apply` requires manual confirmation. In this educational repository, no cloud deployment is executed.

---

## 🔄 Terraform Resource Lifecycle & Destruction Concepts

1. **`terraform destroy` Purpose**:
   `terraform destroy` tears down managed infrastructure in reverse dependency order: the storage account is deleted first, followed by the resource group.
2. **Accidental Deletion Risk**:
   If you remove the `azurerm_storage_account` block from `main.tf` and run `terraform apply`, Terraform will schedule the deletion of the storage account and all its contained blobs. Always review the plan carefully before applying.
3. **No Unattended Destruction**:
   Never use `terraform destroy -auto-approve`. All infrastructure modifications require human review and automated CI validation.

---

## 🤖 CI/CD Automation (GitHub Actions)

This repository includes a continuous integration workflow in `.github/workflows/validate.yml` that validates syntax and configuration consistency across the root module and both example directories on every push and pull request.

---

## 👨‍💻 Author Information

- **Developer**: Vishal Yadav (`vishalnik002-git`)
- **Education**: MCA @ Galgotias University (2025–2027) | BCA @ MGKVP (2022–2025)
- **Role**: DevOps Intern @ DevOps Insiders
- **GitHub Profile**: [https://github.com/vishalnik002-git](https://github.com/vishalnik002-git)
