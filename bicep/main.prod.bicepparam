using 'main.bicep'

param location = 'uksouth'
param environmentType = 'prod'
param appServicePlanName = 'myAppServicePlan${environmentType}'
param webAppName = 'myWebApp${environmentType}'
param cosmosDbName = 'myCosmosDb${environmentType}'
param cosmosDbDatabaseThroughput = 1200
param tags = {
  environment: environmentType
  project: 'MyProject'
}
