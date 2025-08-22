targetScope = 'tenant'

metadata name = 'Lee Company Custom Management Groups'
metadata description = 'Custom management group structure for Lee Company'

// Parameters
@description('The root management group name')
param parRootMgName string = 'LeeCompany-MG'

@description('The root management group display name') 
param parRootMgDisplayName string = 'Lee Company'

@description('Parent management group ID for LeeCompany-MG')
param parParentManagementGroupId string = '4626f5f3-08a5-4188-8b54-4a1211419e4a'  // Your current parent

// Variables for management group names
var varManagementGroups = {
  root: {
    name: parRootMgName
    displayName: parRootMgDisplayName
  }
  decommissioned: {
    name: 'Decommissioned-MG'
    displayName: 'Decommissioned'
  }
  landingZones: {
    name: 'LandingZones-MG'
    displayName: 'Landing Zones'
  }
  platform: {
    name: 'Platform-MG'
    displayName: 'Platform'
  }
  sandbox: {
    name: 'Sandbox-MG'
    displayName: 'Sandbox'
  }
  legacy: {
    name: 'Legacy-MG'
    displayName: 'Legacy'
  }
    // Landing Zones children (Level 3)
  apps: {
    name: 'Apps-MG'
    displayName: 'Apps'
  }
  core: {
    name: 'Core-MG'
    displayName: 'Core'
  }
  // Core children (Level 4)
  bizOps: {
    name: 'BizOps-MG'
    displayName: 'BizOps'
  }
  dataOps: {
    name: 'DataOps-MG'
    displayName: 'DataOps'
  }
  identityOps: {
    name: 'IdentityOps-MG'
    displayName: 'IdentityOps'
  }
  prophix: {
    name: 'Prophix-MG'
    displayName: 'Prophix'
  }
  secOps: {
    name: 'SecOps-MG'
    displayName: 'SecOps'
  }
  
  // Platform children remain the same
  connectivity: {
    name: 'Connectivity-MG'
    displayName: 'Connectivity'
  }
  management: {
    name: 'Management-MG'
    displayName: 'Management'
  }
}

// Level 1 - Root Management Group (keeping its current parent)
resource resRootMg 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: varManagementGroups.root.name
  properties: {
    displayName: varManagementGroups.root.displayName
    details: {
      parent: {
        id: tenantResourceId('Microsoft.Management/managementGroups', parParentManagementGroupId)
      }
    }
  }
}

// Level 2 - Direct children of LeeCompany-MG
resource resDecommissionedMg 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: varManagementGroups.decommissioned.name
  properties: {
    displayName: varManagementGroups.decommissioned.displayName
    details: {
      parent: {
        id: resRootMg.id
      }
    }
  }
}

resource resLandingZonesMg 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: varManagementGroups.landingZones.name
  properties: {
    displayName: varManagementGroups.landingZones.displayName
    details: {
      parent: {
        id: resRootMg.id
      }
    }
  }
}

resource resPlatformMg 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: varManagementGroups.platform.name
  properties: {
    displayName: varManagementGroups.platform.displayName
    details: {
      parent: {
        id: resRootMg.id
      }
    }
  }
}

resource resSandboxMg 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: varManagementGroups.sandbox.name
  properties: {
    displayName: varManagementGroups.sandbox.displayName
    details: {
      parent: {
        id: resRootMg.id
      }
    }
  }
}

resource resLegacyMg 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: varManagementGroups.legacy.name
  properties: {
    displayName: varManagementGroups.legacy.displayName
    details: {
      parent: {
        id: resRootMg.id
      }
    }
  }
}

// Level 3 - Landing Zones children
resource resAppsMg 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: varManagementGroups.apps.name
  properties: {
    displayName: varManagementGroups.apps.displayName
    details: {
      parent: {
        id: resLandingZonesMg.id
      }
    }
  }
}

resource resCoreMg 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: varManagementGroups.core.name
  properties: {
    displayName: varManagementGroups.core.displayName
    details: {
      parent: {
        id: resLandingZonesMg.id
      }
    }
  }
}

// Level 3 - Platform children
resource resConnectivityMg 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: varManagementGroups.connectivity.name
  properties: {
    displayName: varManagementGroups.connectivity.displayName
    details: {
      parent: {
        id: resPlatformMg.id
      }
    }
  }
}

resource resManagementMg 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: varManagementGroups.management.name
  properties: {
    displayName: varManagementGroups.management.displayName
    details: {
      parent: {
        id: resPlatformMg.id
      }
    }
  }
}

// Level 4 - Core children
resource resBizOpsMg 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: varManagementGroups.bizOps.name
  properties: {
    displayName: varManagementGroups.bizOps.displayName
    details: {
      parent: {
        id: resCoreMg.id
      }
    }
  }
}

resource resDataOpsMg 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: varManagementGroups.dataOps.name
  properties: {
    displayName: varManagementGroups.dataOps.displayName
    details: {
      parent: {
        id: resCoreMg.id
      }
    }
  }
}

resource resIdentityOpsMg 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: varManagementGroups.identityOps.name
  properties: {
    displayName: varManagementGroups.identityOps.displayName
    details: {
      parent: {
        id: resCoreMg.id
      }
    }
  }
}

resource resProphixMg 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: varManagementGroups.prophix.name
  properties: {
    displayName: varManagementGroups.prophix.displayName
    details: {
      parent: {
        id: resCoreMg.id
      }
    }
  }
}

resource resSecOpsMg 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: varManagementGroups.secOps.name
  properties: {
    displayName: varManagementGroups.secOps.displayName
    details: {
      parent: {
        id: resCoreMg.id
      }
    }
  }
}

// Outputs
output outTopLevelManagementGroupId string = resRootMg.id
output outTopLevelManagementGroupName string = resRootMg.name

output outPlatformManagementGroupId string = resPlatformMg.id
output outPlatformManagementGroupName string = resPlatformMg.name

output outLandingZonesManagementGroupId string = resLandingZonesMg.id
output outLandingZonesManagementGroupName string = resLandingZonesMg.name

output outSandboxManagementGroupId string = resSandboxMg.id
output outSandboxManagementGroupName string = resSandboxMg.name

output outDecommissionedManagementGroupId string = resDecommissionedMg.id
output outDecommissionedManagementGroupName string = resDecommissionedMg.name

output outLegacyManagementGroupId string = resLegacyMg.id
output outLegacyManagementGroupName string = resLegacyMg.name

output outLandingZoneChildrenManagementGroupIds array = [
  resAppsMg.id
  resCoreMg.id
]

output outPlatformChildrenManagementGroupIds array = [
  resConnectivityMg.id
  resManagementMg.id
]

output outCoreChildrenManagementGroupIds array = [
  resBizOpsMg.id
  resDataOpsMg.id
  resIdentityOpsMg.id
  resProphixMg.id
  resSecOpsMg.id
]
