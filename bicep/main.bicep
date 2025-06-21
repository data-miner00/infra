param location string = resourceGroup().location
param appServicePlanName string = 'toy-product-starter-${uniqueString(resourceGroup().id)}'
param webAppName string = 'toy-product-app-${uniqueString(resourceGroup().id)}'
param cosmosDbName string
param cosmosDbDatabaseThroughput int

@allowed([
  'dev'
  'prod'
])
param environmentType string

var theStorageAccountName = 'toylaunchstorage${environmentType}'
var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'

module database 'modules/database.bicep' = {
  name: 'database'
  params: {
    storageAccountName: theStorageAccountName
    storageAccountSkuName: storageAccountSkuName
    location: location
    cosmosDbName: cosmosDbName
    cosmosDbDatabaseThroughput: cosmosDbDatabaseThroughput
  }
}

module appService 'modules/appService.bicep' = {
  name: 'appService'
  params: {
    location: location
    appServicePlanName: appServicePlanName
    webAppName: webAppName
    environmentType: environmentType
  }
}

output webAppHostName string = appService.outputs.webAppHostName
output storageAccountId string = database.outputs.storageAccountId
