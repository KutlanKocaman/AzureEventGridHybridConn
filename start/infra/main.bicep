param location string = resourceGroup().location
param relayName string = 'RelayForEventGridHybridConn'
param hybridConnectionName string = 'HybridConnFromEventGrid'
param eventGridTopicName string = 'EventGridToHybridConn'
param eventGridSubscriptionName string = 'SubscriptionToHybridConn'

resource relayNamespace 'Microsoft.Relay/namespaces@2021-11-01' = {
  name: relayName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
}

resource hybridConnection 'Microsoft.Relay/namespaces/hybridConnections@2021-11-01' = {
  name: hybridConnectionName
  parent: relayNamespace
  properties: {}
}

resource eventGridTopic 'Microsoft.EventGrid/topics@2023-12-15-preview' = {
  name: eventGridTopicName
  location: location
  properties: {
    minimumTlsVersionAllowed: '1.0'
    inputSchema: 'EventGridSchema'
    publicNetworkAccess: 'Enabled'
    dataResidencyBoundary: 'WithinGeopair'
  }
  sku: {
    name: 'Basic'
  }
  kind: 'Azure'
}

resource eventGridSubscription 'Microsoft.EventGrid/eventSubscriptions@2023-12-15-preview' = {
  name: eventGridSubscriptionName
  scope: eventGridTopic
  properties: {
    destination: {
      endpointType: 'HybridConnection'
      properties: {
        resourceId: hybridConnection.id
      }
    }
  }
}
