$resourcegroup = "_prefix_netappk8s"
$clustername = "_prefix_k8s"
$acrname = "_prefix_k8s4acr"
$image = "sample/postgresql13:v1"



az aks get-credentials --resource-group $resourcegroup  --name $clustername
az acr login --name $($acrname + ".azurecr.io")
az acr build --resource-group $resourcegroup --image $image  --registry $acrname --file Dockerfile .



kubectl get pods -l app=nginx0 -o wide

kubectl get svc --all-namespaces

kubectl describe pod  nginx0-deployment-6d98488744-fcj4b

az network public-ip create `
    --resource-group $resourcegroup `
    --name aksexternaip `
    --sku Standard `
    --allocation-method static

az aks show -g $resourcegroup -n $acrname --query "identity"


#az role assignment create  --assignee 769145cb-fa5d-4030-9ce4-baace3eb3f4a  --role "Contributor"  --scope /subscriptions/dc5d3c89-36dd-4a3c-b09b-e6ee41f6d5b5/resourceGroups/tsukak8s20210122

kubectl apply -f .\yaml\pv-nfs.yaml
kubectl apply -f .\yaml\configmap.yaml
kubectl apply -f .\yaml\postgresql-stateful.yaml

#kubectl apply -f .\yaml\postgresql-stateful.yaml


kubectl get pod postgresql-nfs -o wide
kubectl describe pod postgres-statefulset-0
kubectl logs postgres-statefulset-0
kubectl exec --stdin --tty postgres-statefulset-0 -- /bin/bash