resource storageAccount 'Microsoft.Storage/storageAccounts@2024-01-01' = {
  name: 'toylaunchstorage'
  location: 'eastus'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: false
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2024-11-01' = {
  name: 'toy-product-starter'
  location: 'eastus'
  sku:{
    name: 'F1'
  }
}

resource webApp 'Microsoft.Web/sites@2024-11-01' = {
  name: 'toy-product-app'
  location: 'eastus'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}
