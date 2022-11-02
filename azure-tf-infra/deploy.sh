for i in $@
do
var=$(echo $i | cut -f1 -d =)
declare $var=$(echo $i | cut -f2- -d =)
done

username=${username:? Username Required}
password=${password:? Password Required}
file=$file
while IFS== read key value; do
    printf -v "$key" "$value"
done < <(jq 'to_entries|map("\(.key)=\(.value|tostring)")|.[]' $file | sed -e 's/^"//' -e 's/"$//')

[[ -z "$region" ]] && region="eastus2"
[[ -z "$resource_group_name" ]] && resource_group_name="kloudjet-angular-rg"
[[ -z "$storage_account_name" ]] && storage_account_name="kloudjetangularstorage01"
[[ -z "$account_kind" ]] && account_kind="StorageV2"
[[ -z "$account_tier" ]] && account_tier="Standard"
[[ -z "$account_replication_type" ]] && account_replication_type="LRS"
[[ -z "$index_document" ]] && index_document="index.html"
[[ -z "$appinsights_name" ]] && appinsights_name="kloudjet-azure-angular"
[[ -z "$application_type" ]] && application_type="web"

echo "Following variables will be used for deployment..."
echo region: $region
echo resource_group_name: $resource_group_name
echo storage_account_name: $storage_account_name
echo account_kind: $account_kind
echo account_tier: $account_tier
echo account_replication_type: $account_replication_type
echo index_document: $index_document
echo appinsights_name: $appinsights_name
echo application_type: $application_type

cd ../angular-frontend
echo "Installing dependencies..."
npm install
echo "Building your project..."
npm run build
cd ../azure-tf-infra

echo "Azure Login..."
az login -u $username -p $password

echo "Initializing..."
terraform init
echo "Setting it up will take few minutes...."
terraform apply -var region=$region -var resource_group_name=$resource_group_name -var storage_account_name=$storage_account_name -var account_kind=$account_kind -var account_tier=$account_tier -var account_replication_type=$account_replication_type -var index_document=$index_document -var appinsights_name=$appinsights_name -var application_type=$application_type --auto-approve

cd ../angular-frontend
bash az storage blob upload-batch --account-name $storage_account_name  -s ./dist -d '$web'

echo "Everything is ready...."
echo "::To destroy everything run"
echo ":: terraform destroy -auto-approve"