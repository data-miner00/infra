metadata description = 'Creates multiple storage accounts.'

// resource group is the default value so don't need to specify here
targetScope =  'resourceGroup'

@allowed([
  'dev'
  'prod'
])
param environmentType string

// Loops to create multiple storage accounts in specifies regions
var enforcedRegions = [
  'eastus'
  'northeurope'
  'southeastasia'
]

resource enforcedStorageAccounts 'Microsoft.Storage/storageAccounts@2024-01-01' = [for (region, index) in enforcedRegions: {
  name: toLower('efs${index}${region}')
  location: region
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: false
  }
}]

resource additionalStorageAccount 'Microsoft.Storage/storageAccounts@2024-01-01' = if (environmentType == 'dev') {
  name: toLower('addt${uniqueString(resourceGroup().id)}')
  location: resourceGroup().location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: false
  }
}
