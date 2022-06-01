#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/runtime:3.1 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src
COPY ["ConsoleApp2.csproj", "."]
RUN dotnet restore "./ConsoleApp2.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "ConsoleApp2.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ConsoleApp2.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ConsoleApp2.dll"]