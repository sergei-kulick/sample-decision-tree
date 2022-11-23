#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["sample-decision-tree.csproj", "sample-decision-tree/"]
RUN dotnet restore "sample-decision-tree/sample-decision-tree.csproj"

WORKDIR "/src/sample-decision-tree"
COPY . .

RUN dotnet build "sample-decision-tree.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "sample-decision-tree.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .

ENTRYPOINT ["dotnet", "sample-decision-tree.dll"]