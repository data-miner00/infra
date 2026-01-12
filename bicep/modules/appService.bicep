metadata description = 'Creates a new web app along with a new app service plan'

@description('Location for all resources.')
param location string

@description('Name of the App Service Plan.')
param appServicePlanName string

@description('Name of the Web App.')
param webAppName string

@description('Environment of the deployment.')
@allowed([ 'dev', 'prod' ])
param environmentType string

@description('Tags to apply to all resources.')
param tags object = {}

var appServicePlanSkuName = (environmentType == 'prod') ? 'P2V3' : 'F1'

resource appServicePlan 'Microsoft.Web/serverfarms@2024-11-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
  }
  tags: tags
}

resource webApp 'Microsoft.Web/sites@2024-11-01' = {
  name: webAppName
  location: location
  properties:{
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
  tags: tags
}

@description('The default hostname of the web app.')
output webAppHostName string = webApp.properties.defaultHostName
