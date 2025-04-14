docker build -t blog-do-jan:latest .

#detached mode". 
# Quando você usa essa opção, o container é executado em segundo plano (background) e o 
# terminal não fica "preso" ao processo do container. Ele retorna apenas o ID do container iniciado.


docker run -d -p 8089:80 blog-do-jan:latest

az login az l

# Create a resource group
az group create --name containerappslab003janei --location eastus

# Create Container Registry
az acr create --resource-group containerappslab003janei --name blogdojanacr --sku Basic

# Login to ACR
az acr login --name blogdojanacr

# Tag the image
docker tag blog-do-jan:latest blogdojanacr.azurecr.io/blog-do-jan:latest

# Push the image
docker push blogdojanacr.azurecr.io/blog-do-jan:latest

#containerID = blogdojanacr.azurecr.io/blog-do-jan:latest
#user =  blogdojanacr
#password = ""

# Create Environment container app
az containerapp env create --name blog-do-jan-env --resource-group containerappslab003janei --location eastus

# Create Container App
az containerapp create --name blog-do-jan-app --resource-group containerappslab003janei --image blogdojanacr.azurecr.io/blog-do-jan:latest --environment blog-do-jan-env --target-port 80 --ingress external --registry-username blogdojanacr --registry-password "senha" --registry-server blogdojanacr.azurecr.io

