using 'main.bicep'

param location = 'eastus'
param environmentType = 'dev'
param appServicePlanName = 'myAppServicePlan${environmentType}'
param webAppName = 'myWebApp${environmentType}'
param cosmosDbName = 'myCosmosDb${environmentType}'
param cosmosDbDatabaseThroughput = 400
param tags = {
  environment: environmentType
  project: 'MyProject'
}
