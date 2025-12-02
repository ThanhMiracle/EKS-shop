# RUN THESE COMMANDS MANUALLY (one time)
kubectl create secret generic minio-secret \
  --namespace myapp \
  --from-literal=accesskey="minioadmin" \
  --from-literal=secretkey="minioadmin123"

kubectl create secret generic app-secrets \
  --namespace myapp \
  --from-literal=DATABASE_URL="postgresql://pgadmin:YourPassword@<PG_FQDN>:5432/appdb?sslmode=require" \
  --from-literal=JWT_SECRET="super-secret-key" \
  --from-literal=JWT_EXPIRE_MINUTES="60"

kubectl create secret generic azurefiles-secret \
  --namespace myapp \
  --from-literal=azurestorageaccountname="<STORAGE_ACCOUNT_NAME>" \
  --from-literal=azurestorageaccountkey="<STORAGE_KEY>"


terraform output -raw kube_config_raw > kubeconfig
export KUBECONFIG=./kubeconfig