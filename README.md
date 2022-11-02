# Creating Angular Frontend on Azure (azure-tf-angular-frontend)
This component consists of two folders
| S.no | Folder Name | Description |
| ---- | ------ | ------ |
| 1 | azure-tf-infra | Contains the Azure and Terraform infrastructure code |
| 2 | angular-frontend | Contains a frontend application created using angular and CSS. |

### Pre-requisites

1. Terraform CLI
2. An Azure account. If you don't already have one, you can sign up for a [free trial](https://azure.microsoft.com/en-us/free/) that includes $200 of free credit.

### Requirements

| Name |	Version|
| ------ | ------ |
| Azure CLI | >= 2.23.0 |
| Terraform | >= 1.1.5 |
| Node.js | >= 16.14.0 |
| Angular CLI | >= 7.2.0 |

### Providers

| Name | Version |
|------|---------|
| Azure | >= 2.23.0 |

### Inputs

| Name | Description | Type |	Default	| Required |
| ------ | ------ | ------ | ------ | ------ |
| username | Azure account username | string | | Yes |
| password | Azure account password | string | | Yes |
| region | The Azure Region in which all resources in this template should be created | string | East US 2 | Yes |
| resource_group_name | The name of the resource group | string | kloudjet-angular-rg | Yes |
| storage_account_name | The name of the storage account | string | kloudjetangularstorage01 | Yes |
| account_kind | Each type supports different features and has its own pricing model | string | StorageV2 | Yes |
| account_tier | Storage account tier - Basic, Standard or Premium | string | Standard | Yes |
| account_replication_type | How your data is replicated in the primary region | string | LRS | Yes |
| index_document | Static website where application will start | string | index.html | Yes |
| appinsights_name | The name for the application insights | string | kloudjet-azure-angular | Yes |
| application_type | The type of application | string | web | Yes |

## Outputs

Output on the console after successful provisioning is:

| Name | Description |
|------|-------------|
| INSTRUMENTATION_KEY | The instrumentation key identifies the resource that you want to associate your telemetry data with.
| AZURE_STORAGE_CONNECTION_STRING | A connection string includes the authorization information required for your application to access data in an Azure Storage account at runtime using Shared Key authorization
| WEBSITE | URL endpoint of the application

## Usage

- Update the GET_API, ADD_API, DEL_API in the environment.ts file under the angular-frontend\src\environments folder.

- Run the following command for Windows, in the root directory : 

    ```

    deploy.bat username:<username> password:<password> region:<region> resource_group_name:<resource_group_name> storage_account_name:<storage_account_name> account_kind:<account_kind> account_tier:<account_tier> account_replication_type:<account_replication_type> index_document:<index_document> appinsights_name:<appinsights_name> application_type:<application_type>

    ```
    
- Run the following command for Linux, in the root directory : 

    ```

    bash deploy.sh username=<username> password=<password> region=<region> resource_group_name=<resource_group_name> storage_account_name=<storage_account_name> account_kind=<account_kind> account_tier=<account_tier> account_replication_type=<account_replication_type> index_document=<index_document> appinsights_name=<appinsights_name> application_type=<application_type>

    ```

- Replace the above mentioned <variable_name> with the values of your choice.

## Running the template manually

- Update the variable values in variables.tf file according to your need.
- Now run the following commands under root directory of the template.

    ```

    az login -u <username> -p <password>
    terraform init
    terraform apply

    ```
- Upload dist folder on Azure blob storage

    ```bash

    cd angular-frontend
    az storage blob upload-batch --account-name <storage_account_name>  -s ./dist -d '$web'

    ```
- Run `terraform destroy` to destroy all created resources.