**Introduction**

In this post we will build a Docker image from a Dockerfile, run the image inside a container locally that will execute a bash script, write Terraform configuration to build our cloud infrastructure required to run the container in Azure & finally test our image inside an Azure Container App Job. 
The goal is to get you to test the services so I will supply a repo you can clone with some finished code so you can easily follow along and test the commands out for yourself. You will need: 
An Azure Subscription
Docker installed on your system
Terraform installed on your system
AZ CLI installed on your system
Git installed on your system 
The scenario
We have a resource group with very sensitive resources that are central part of our environments monitoring strategy. We want to ensure that any updates to these resources and alerts happen with great care. If someone is to make a change they first need to unlock the resource-group by removing the resource lock we have applied. 
They should make their changes and then re-apply the lock. However we have noticed that administrators tend to forget to re-lock the RG. For this we want a scheduled task that runs every night that runs a command to apply the lock, ensuring the resources are locked even if the admins forget. az lock create --name rgLock --resource-group rg-alz-monitor --lock-type ReadOnly


References