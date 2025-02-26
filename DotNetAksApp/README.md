# .NET AKS Sample Application

This is a sample ASP.NET Core application that demonstrates deployment to Azure Kubernetes Service (AKS) using GitHub Actions.

## Project Structure

- `DotNetAksApp.csproj` - The .NET project file
- `Program.cs` - The main entry point for the application
- `Controllers/` - Contains the MVC controllers
- `Views/` - Contains the Razor views
- `Dockerfile` - Instructions for building the application container image
- `k8s/` - Kubernetes manifest files for deploying to AKS

## Prerequisites

- Azure subscription
- Azure Container Registry (ACR)
- Azure Kubernetes Service (AKS) cluster
- GitHub repository with GitHub Actions enabled

## Local Development

To run the application locally:

```bash
cd DotNetAksApp
dotnet restore
dotnet run
```

## Docker Build

To build and run the Docker container locally:

```bash
cd DotNetAksApp
docker build -t dotnetaks-app:latest .
docker run -p 8080:80 dotnetaks-app:latest
```

## Deployment to AKS

This project is configured for continuous deployment to AKS using GitHub Actions.

### Required Secrets for GitHub Actions

Set up the following secrets in your GitHub repository:

- `AZURE_CREDENTIALS` - Azure service principal credentials
- `ACR_USERNAME` - Azure Container Registry username
- `ACR_PASSWORD` - Azure Container Registry password

### Manual Deployment

To deploy manually to AKS:

1. Build and push the Docker image to ACR:
```bash
docker build -t <your-acr>.azurecr.io/dotnetaks-app:latest .
docker push <your-acr>.azurecr.io/dotnetaks-app:latest
```

2. Apply the Kubernetes manifests:
```bash
kubectl apply -f k8s/config-map.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

### Accessing the Application

After deployment, the application will be accessible through the Kubernetes service's external IP:

```bash
kubectl get svc dotnetaks-service
```

Use the EXTERNAL-IP to access the application in a web browser.