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
    var url: URL?
    
    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: type(of: self))
        guard let murl = bundle.url(forResource: "DataTest", withExtension: "json") else {
            XCTFail("No file found")
            return
        }
        
        url = murl
        data = try? Data(contentsOf: url!)
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
        let client = Client()
        client.fetchRemoteData(request: url!, dataHandler: .roadHandler, completion: {data, error in
            guard error == nil else {
                XCTFail()
                return
            }
            guard let data = data as? [Road] else {
                XCTFail()
                return
            }
            
            let roadData = data[0]
            XCTAssertEqual(roadData.displayName, "A3")
            XCTAssertEqual(roadData.statusSeverity, "Good")
            XCTAssertEqual(roadData.statusSeverityDescription, "No Exceptional Delays")
        })
    }
    
}
