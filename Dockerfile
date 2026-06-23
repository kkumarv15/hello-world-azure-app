FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
EXPOSE 8080

COPY HelloWorld/publish/. ./

RUN useradd -m myappuser && chown -R myappuser /app
USER myappuser

ENTRYPOINT ["dotnet", "HelloWorld.dll"]
