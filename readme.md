This repo shows how to set up an event grid subscription to a "hybrid connection" endpoint.

Prerequisites:
1. A resource group in Azure called EventGridHybridConnectionRG
2. A service connection able to deploy to the EventGridHybridConnectionRG resource group (replace kk-service-connection with the name of your service connection in azure-pipelines.yml)

Steps:
1. Set up a DevOps pipeline using the azure-pipelines.yml file
2. Run the pipeline to deploy the bicep file which will create the following resources
    1. Azure Relay
    2. Hybrid Connection
    3. Event Grid Topic
    4. Event Grid Subscription
3. Get the connection string from the Azure Relay (Shared Access Policies) and put it in the relayConnectionString string in the HybridConnectionConsumer project Program.cs
4. Run the HybridConnectionConsumer Project (the Hybrid Connection the Azure Portal should now show 1 listener)
5. Get the Event Grid connection string (Overview "Topic endpoint") put it in the eventGridConnectionString string in the EventGridPublisher project Program.cs
6. Get the Event Grid access key (Access keys) and put it in the eventGridAccessKey string in the EventGridPublisher project Program.cs
7. Run the EventGridPublisher project (with the HybribConnectionConsumer project still running)
8. Type some text into the EventGridPublisher and see it appear in the HybridConnectionConsumer output

HybridConnectionConsumer is based on: https://github.com/Azure-Samples/event-grid-dotnet-hybridconnection-destination