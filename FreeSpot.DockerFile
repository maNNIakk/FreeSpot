# See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
USER app
WORKDIR /app
EXPOSE 32769
EXPOSE 32768

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Development
WORKDIR /src

# Copy the project file separately
COPY ["FreeSpot/FreeSpot.csproj", "FreeSpot/"]

# Restore NuGet packages
RUN dotnet restore "./FreeSpot/FreeSpot.csproj"

# Copy the remaining source code
COPY . .

WORKDIR "/src/FreeSpot"
RUN dotnet build "FreeSpot.csproj" -c $BUILD_CONFIGURATION -o /app/build

FROM build AS publish
ARG BUILD_CONFIGURATION=Development
RUN dotnet publish "FreeSpot.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "FreeSpot.dll"]