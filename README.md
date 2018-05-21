 **How to build and run the code**</br>There are no particular requirements in order to build and run the program. Open the TFLRoadStatus.xcodeproj file with Xcode , change the  app_key and app_id in the Constants file and build and run as usual.

**How to run any tests that you have written**</br>Tests have been written using XCTest. So it's straightforward running them.

 **API behaviuor**</br>I had to do some extra work because of the way the API returns json format depending on the success or not of the request. In particular if the GET request is successfull (200) the json returned is an array, if the response is 404 the json is an object.

**TDD and unit testing**</br>I tried to use a TDD approach to complete the task. However I would have done more to make my code testable. To unit test the network connection (Client class) I used a mock URLSession (MockURLSession) and injected in the Client using a custom protocol (URLSessionProtocol).

**Using your app_key and app_id**</br>Locate the file Constants and change the constants AppID and AppKey with your data:
``` 
struct TflParameterValues {
        static let AppID = "<YOUR application ID>"
        static let AppKey = "<YOUR application key>"
    }
```
