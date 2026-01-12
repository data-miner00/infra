metadata description = 'Provisions VM in an existing VNet'

param vmName string
param location string
param vmSize string = 'Standard_D2s_v3'
param tags object = {}

resource vm 'Microsoft.Compute/virtualMachines@2024-11-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface.id
        }
      ]
    }
  }
  tags: tags

  resource installCustomScriptsExtension 'extensions' = {
    name: 'InstallCustomScript'
    location: location
    tags: tags
  }
}

resource installCustomScriptsExtension2 'Microsoft.Compute/virtualMachines/extensions@2024-11-01' = {
  parent: vm
  name: 'InstallCustomScript2'
  location: location
  tags: tags
}

resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' existing = {
  scope: resourceGroup('networking-rg')
  name: 'toy-design-vnet'
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2024-07-01' = {
  name: 'my-network-interface'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: vnet.properties.subnets[0].id
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
  tags: tags
}

output vmInstallCustomScriptsId string = vm::installCustomScriptsExtension.id
