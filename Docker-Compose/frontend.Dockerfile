# Dockerfile for ASP.NET Core frontend
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# Copy csproj and restore dependencies
COPY ["Frontend/Frontend.csproj", "Frontend/"]
RUN dotnet restore "Frontend/Frontend.csproj"

# Copy all files and build
COPY ["Frontend/", "Frontend/"]
WORKDIR "/src/Frontend"
RUN dotnet build "Frontend.csproj" -c Release -o /app/build

# Publish the application
FROM build AS publish
RUN dotnet publish "Frontend.csproj" -c Release -o /app/publish

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Frontend.dll"]