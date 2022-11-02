@echo off
for %%i in (%*) do (
    set v=%%i
    for /f "tokens=1,2 delims=:" %%a IN ("%%i") DO (
        set %%a=%%b
    )
)
if "%username%"==""  echo "Username Required" && exit /B 1s
if "%password%"==""  echo "Password Required" && exit /B 1s

IF NOT DEFINED region SET "region=eastus2"
IF NOT DEFINED resource_group_name SET "resource_group_name=kloudjet-angular-rg"
IF NOT DEFINED storage_account_name SET "storage_account_name=kloudjetangularstorage01"
IF NOT DEFINED account_kind SET "account_kind=StorageV2"
IF NOT DEFINED account_tier SET "account_tier=Standard"
IF NOT DEFINED account_replication_type SET "account_replication_type=LRS"
IF NOT DEFINED index_document SET "index_document=index.html"
IF NOT DEFINED appinsights_name SET "appinsights_name=kloudjet-azure-angular"
IF NOT DEFINED application_type SET "application_type=web"

echo "Following variables will be used for deployment..."
echo region: %region%
echo resource_group_name: %resource_group_name%
echo storage_account_name: %storage_account_name%
echo account_kind: %account_kind%
echo account_tier: %account_tier%
echo account_replication_type: %account_replication_type%
echo index_document: %index_document%
echo appinsights_name: %appinsights_name%
echo application_type: %application_type%

cd ../angular-frontend
echo "Installing dependencies..."
cmd /C npm install
echo "Building your project..."
cmd /C npm run build
cd ../azure-tf-infra

echo "Azure Login..."
cmd /C az login -u "%username%" -p "%password%"

echo "Initializing..."
terraform init
echo "Setting it up will take few minutes...."
terraform apply -var region=%region% -var resource_group_name=%resource_group_name% -var storage_account_name=%storage_account_name% -var account_kind=%account_kind% -var account_tier=%account_tier% -var account_replication_type=%account_replication_type% -var index_document=%index_document% -var appinsights_name=%appinsights_name% -var application_type=%application_type% --auto-approve

cd ../angular-frontend
cmd /C bash az storage blob upload-batch --account-name %storage_account_name%  -s ./dist -d '$web'

cd ../azure-tf-infra
terraform output

echo "Everything is ready...."
echo "::To destroy everything run"
echo ":: terraform destroy -auto-approve"