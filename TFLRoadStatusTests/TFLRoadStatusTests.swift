//
//  TFLRoadStatusTests.swift
//  TFLRoadStatusTests
//
//  Created by doc on 12/05/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import XCTest
@testable import TFLRoadStatus

class TFLRoadStatusTests: XCTestCase {
    
    var data: Data?
    var dataNotFound: Data?
    let murl = URL(string: "https://api.tfl.gov.uk/")
    
    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "DataTest", withExtension: "json") else {
            XCTFail("No file found")
            return
        }
        
        data = try? Data(contentsOf: url)
        
        guard let burl = bundle.url(forResource: "DataTestNotFound", withExtension: "json") else {
            XCTFail("No file found")
            return
        }
        
         dataNotFound = try? Data(contentsOf: burl)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDataParser() {
        if let data = data {
            let parsingResult: ([Road]?, ErrorData?) = DataParser.parseJson(data: data)
            if let roadData = parsingResult.0 {
                XCTAssertEqual(roadData[0].displayName, "A3")
                XCTAssertEqual(roadData[0].statusSeverity, "Good")
                XCTAssertEqual(roadData[0].statusSeverityDescription, "No Exceptional Delays")
            }else {
                XCTFail()
            }
        }else {
            XCTFail()
        }
    }
    
    func testClient() {
        let expectation = XCTestExpectation(description: "Fetch Json data")
        let responseCode = HTTPURLResponse(url: murl!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let session = MockURLSession(data: data, responseCode: responseCode, error: nil)
        let client = Client(session: session)
        
        client.fetchRemoteData(request: murl!, completion: {data, error in
            guard error == nil else {
                XCTFail(error.debugDescription)
                return
            }
            guard let data = data as? Road else {
                XCTFail()
                return
            }
            
            let roadData = data
            XCTAssertEqual(roadData.displayName, "A3")
            XCTAssertEqual(roadData.statusSeverity, "Good")
            XCTAssertEqual(roadData.statusSeverityDescription, "No Exceptional Delays")
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10.0)

    }
    
    func testClientError() {
        let expectation = XCTestExpectation(description: "Fetch Json data")
        let error = NSError(domain: "", code: 101, userInfo: nil)
        let session = MockURLSession(data: data, responseCode: nil, error: error)
        let client = Client(session: session)
        
        client.fetchRemoteData(request: murl!, completion: {data, error in
            
            XCTAssertNotNil(error, "Error shouldn't be nil")
            XCTAssertNil(data, "Data should be nil in case of error")
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    func testClient404ResponseCode() {
        let expectation = XCTestExpectation(description: "Fetch Not Found Json data")
         let responseCode = HTTPURLResponse(url: murl!, statusCode: 404, httpVersion: nil, headerFields: nil)
        
        XCTAssert(responseCode?.statusCode == 404, "The response code is not 404")
        
        let session = MockURLSession(data: dataNotFound, responseCode: responseCode, error: nil)
       
        let client = Client(session: session)
        
        client.fetchRemoteData(request: murl!, completion: {data, error in
            guard error == nil else {
                XCTFail(error.debugDescription)
                return
            }
            guard let data = data as? ErrorRoad else {
                XCTFail()
                return
            }
            
            let roadData = data
            XCTAssertEqual(roadData.httpStatus, "NotFound")
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    // Change the url string accordingly to your app_id and app_key
    func testBuildUrl() {
        let buildUrl = BuildUrl(searchItem: "A3", basePath: Constants.Client.basePath)
        let testUrl = buildUrl.getUrl()
        guard let url = testUrl else {
            XCTFail()
            return
        }
        XCTAssertEqual(url.absoluteString, "https://api.tfl.gov.uk/Road/A3?app_id=%3CYOUR%20application%20ID%3E&app_key=%3CYOUR%20application%20key%3E")
    }
    
}
