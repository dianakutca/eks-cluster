Kubernetes Dashboard Setup Instructions
---

### Step 1: Deploying Kubernetes Dashboard with Helm
###### ! In our case deployment done from bastion EC2 instance, so it has to have neccessary ports open: 8443, HTTPS , SSH 

Install Helm (if it isn't already installed):

``````
# curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
# chmod +x get_helm.sh
# ./get_helm.sh
# helm version
``````

Documentation used below : 
```
https://artifacthub.io/packages/helm/k8s-dashboard/kubernetes-dashboard
```


Deploy the Kubernetes Dashboard using default values.yaml file:


``````
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/

helm install kubernetes-dashboard  kubernetes-dashboard/kubernetes-dashboard  -f values.yaml
``````

Follow the instruction of the output
``````
# export POD_NAME=$(kubectl get pods -n default -l "app.kubernetes.io/name=kubernetes-dashboard,app.kubernetes.io/instance=kubernetes-dashboard" -o jsonpath="{.items[0].metadata.name}")

# echo https://127.0.0.1:8443/

# nohup kubectl -n default port-forward --address 0.0.0.0 $POD_NAME 8443:8443 > port-forward.log 2>&1 & (changed to run app on the background)
``````

Dashboard accessible at: https://YOUR_IP:8443

### Step2. Authenticating to the Dashboard

1. Create secret (kubectl apply my-sec.yaml)
2. create service account 
3. using file mail.yaml create Role, RoleBinding 

``````
TOKEN=$(kubectl get secret $(kubectl get serviceaccount test -n kubernetes-dashboard -o jsonpath='{.secrets[0].name}') -n kubernetes-dashboard -o jsonpath='{.data.token}' | base64 -d)

CLUSTER_NAME=$(kubectl config get-contexts $(kubectl config current-context) | awk '{print $3}' | tail -n 1)


kubectl config set-cluster ${CLUSTER_NAME} \
--kubeconfig=dashboard-kubeconfig \
--server=$(kubectl config view -o=jsonpath="{.clusters[?(@.name==\"${CLUSTER_NAME}\")].cluster.server}") \
--certificate-authority=$(kubectl config view -o=jsonpath="{.clusters[?(@.name==\"${CLUSTER_NAME}\")].cluster.certificate-authority}")

kubectl config set-credentials test-dashboard \
--kubeconfig=dashboard-kubeconfig \
--token="${TOKEN}"

kubectl config set-context test-dashboard@${CLUSTER_NAME} \
--kubeconfig=dashboard-kubeconfig \
--cluster=${CLUSTER_NAME} \
--user=test-dashboard

kubectl config use-context test-dashboard@${CLUSTER_NAME} --kubeconfig=dashboard-kubeconfig

``````

# On EC2
aws s3 cp /home/ec2-user/eks-cluster/dashboard-kubeconfig s3://terraform-project-dianakutca-eks-setup/

