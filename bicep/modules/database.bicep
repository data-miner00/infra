param storageAccountName string
param location string
param storageAccountSkuName string
param cosmosDbName string
param cosmosDbDatabaseThroughput int

var databaseName = 'Toy'
var containerName = 'Toys'
var partitionKey = '/toyId'

resource storageAccount 'Microsoft.Storage/storageAccounts@2024-01-01' = {
  name: storageAccountName
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

resource cosmosDb 'Microsoft.DocumentDB/databaseAccounts@2025-04-15' = {
  name: cosmosDbName
  location: location
  properties: {
    databaseAccountOfferType: 'Standard'
    locations: [
      {
        locationName: location
      }
    ]
  }

  resource cosmosDbDatabase 'sqlDatabases' = {
    name: databaseName
    properties: {
      resource: {
        id: databaseName
      }
      options: {
        throughput: cosmosDbDatabaseThroughput
      }
    }

    resource container 'containers' = {
      name: containerName
      properties: {
        resource: {
          id: containerName
          partitionKey: {
            kind: 'Hash'
            paths: [
              partitionKey
            ]
          }
        }
        options: {}
      }
    }
  }
}

resource cosmosDbLock 'Microsoft.Authorization/locks@2020-05-01' = {
  scope: cosmosDb
  name: 'DontDelete'
  properties: {
    level: 'CanNotDelete'
    notes: 'Please do not delete this database.'
  }
}

output storageAccountId string = storageAccount.id
