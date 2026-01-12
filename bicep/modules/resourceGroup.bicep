metadata description = 'Creates a new resource group in UKSouth region.'

targetScope = 'subscription'

param resourceGroupName string

resource newResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: 'uksouth'
}

output resourceGroupId string = newResourceGroup.id
