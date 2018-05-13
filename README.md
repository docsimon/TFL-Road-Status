* How to build and run the code
There are no particular requirements in order to build and run the program. Open the TFLRoadStatus.xcodeproj file with Xcode and that's it.

* How to run any tests that you have written
Tests have been written using XCTest. So it's straightforward running them.

* API behaviuor
I had to do some extra work because of the way the API returns json format depending on the success or not of the request. In particular if the GET request is successfull (200) the json returned is an array, if the response is 404 the json is an object.

* TDD and unit testing
I tried to use a TDD approach to complete the task. However I would have done more to make my code testable. In particular, I unit tested the network connection (Client class) using a real url, while a would have used A mock URLSession, injected in the Client using a custom protocol.

* Using your ppp_key and app_id
Locate the file Constants and change the constants AppID and AppKey with your data:
``` 
struct TflParameterValues {
        static let AppID = "<YOUR application ID>"
        static let AppKey = "<YOUR application key>"
    }
```