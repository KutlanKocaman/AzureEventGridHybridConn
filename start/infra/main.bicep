param location string
param eventGridTopicName string = 'KKEventGridTest'

resource eventGridTopic 'Microsoft.EventGrid/topics@2020-06-01' = {
  name: eventGridTopicName
  location: location
  properties: {}
}
