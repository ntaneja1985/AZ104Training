targetScope = 'subscription'

@description('The Azure region where the resource group will be created.')
param region string = 'eastus'


resource RGDemoBicep 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: 'RGDemoBicep'
  location: region
  tags: {
    environment: 'demo'
  }
}
