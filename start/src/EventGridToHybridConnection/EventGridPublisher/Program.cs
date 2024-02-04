using Azure;
using Azure.Messaging.EventGrid;

string eventGridConnectionString = "";
string eventGridAccessKey = "";

while (true)
{
    Console.WriteLine("Enter your text to be published to event grid then press Enter");
    string text = Console.ReadLine()!;

    var eventGridPublisherClient = new EventGridPublisherClient(
        new Uri(eventGridConnectionString),
        new AzureKeyCredential(eventGridAccessKey));

    EventGridEvent eventGridEvent = new EventGridEvent(
        "TestSubject",
        "TestEventType",
        "1.0",
        text);

    await eventGridPublisherClient.SendEventAsync(eventGridEvent);
    Console.WriteLine("event successfully published");
}