# 🧱 Terraform Azure Storage Account & Implicit Dependency Management

[![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=flat&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/Microsoft_Azure-0078D4?style=flat&logo=microsoft-azure&logoColor=white)](https://azure.microsoft.com/)
[![Dependency Graph](https://img.shields.io/badge/Terraform-Dependency_Graph-blue)](https://developer.hashicorp.com/terraform/language/resources/behavior#resource-dependencies)

---

## 📌 Project Overview

This project demonstrates how Terraform automatically constructs an internal **Dependency Graph** to manage resource provisioning order using **Implicit Dependencies**.

In cloud environments, certain resources cannot exist without a parent container. An Azure Storage Account requires a valid Resource Group. By referencing the parent resource group's attribute directly, Terraform understands that the Resource Group must be created first without needing manual intervention.

---

## 🏗️ Architecture & Implicit Dependency Flow

```text
azurerm_resource_group.rg_dev (East US)
      │
      ▼ (Implicit Dependency: resource_group_name = azurerm_resource_group.rg_dev.name)
azurerm_storage_account.sg_storage (Standard_LRS)
```

* **Implicit Dependency:** In `storage.tf`, `resource_group_name = azurerm_resource_group.rg_dev.name` dynamically pulls the resource group name from the resource defined in `main.tf`.
* **Creation Order:** Terraform creates `rg_dev` first, waits for Azure API confirmation, then initiates `sg_storage`.
* **Destruction Order:** On `terraform destroy`, Terraform automatically reverses this order (deletes storage account before deleting the resource group).

---

## 📁 Repository Structure

```text
.
├── main.tf              # Resource Group definition (rg_dev)
├── storage.tf           # Storage Account definition with implicit reference
├── provider.tf          # AzureRM provider configuration
├── .gitignore           # Git ignore rules for state files
└── README.md            # Project documentation
```

---

## 🚀 How to Run

### Prerequisites
* [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) authenticated (`az login`)
* [Terraform CLI](https://developer.hashicorp.com/terraform/downloads) (>= 1.5.0)

### Steps

```bash
# 1. Clone repository
git clone https://github.com/vishalnik002-git/terraform-storage-account.git
cd terraform-storage-account

# 2. Authenticate to Azure
az login

# 3. Initialize Terraform
terraform init

# 4. Preview execution plan
terraform plan

# 5. Provision resources
terraform apply -auto-approve
```

---

## 🧹 Clean Up

```bash
terraform destroy -auto-approve
```

---

## 👤 Author
* **Vishal Yadav** — [GitHub Profile](https://github.com/vishalnik002-git) | [LinkedIn](https://www.linkedin.com/in/vishal-yadav002)
