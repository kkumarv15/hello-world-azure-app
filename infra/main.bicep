@description('Base name for all resources')
param appName string

@description('Environment label (dev, uat, prod)')
param environment string

@description('Azure region for deployment')
param location string

@description('.NET runtime version for App Service')
param dotnetVersion string = 'DOTNETCORE|8.0'

param resourceGroupName string = 'rg-${appName}-${environment}'

var baseName = '${appName}-${environment}'

resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: 'asp-${baseName}'
  location: location
  sku: {
    name: 'F1'
    tier: 'Free'
    size: 'F1'
    family: 'F'
    capacity: 1
  }
  kind: 'linux'
  properties: { reserved: true }
}

resource webApp 'Microsoft.Web/sites@2023-01-01' = {
  name: 'app-${baseName}'
  location: location
  kind: 'app,linux'
  identity: { type: 'SystemAssigned' }
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: dotnetVersion
      alwaysOn: false
      minTlsVersion: '1.2'
      ftpsState: 'Disabled'
      appSettings: [
        { name: 'ASPNETCORE_ENVIRONMENT', value: environment }
      ]
    }
  }
  dependsOn: [ appServicePlan ]
}

output webAppName string = webApp.name
output webAppHostName string = webApp.properties.defaultHostName
