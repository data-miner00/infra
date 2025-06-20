param location string = resourceGroup().location
param appServicePlanName string = 'toy-product-starter-${uniqueString(resourceGroup().id)}'
param webAppName string = 'toy-product-app-${uniqueString(resourceGroup().id)}'

@allowed([
  'dev'
  'prod'
])
param environmentType string

var theStorageAccountName = 'toylaunchstorage'
var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'
var appServicePlanSkuName = (environmentType == 'prod') ? 'P2V3' : 'F1'

resource storageAccount 'Microsoft.Storage/storageAccounts@2024-01-01' = {
  name: theStorageAccountName
  location: location
  sku: {
    name: storageAccountSkuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: false
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2024-11-01' = {
  name: appServicePlanName
  location: location
  sku:{
    name: appServicePlanSkuName
  }
}

resource webApp 'Microsoft.Web/sites@2024-11-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}
