//
//  MockURLSession.swift
//  TFLRoadStatus
//
//  Created by doc on 20/05/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import Foundation
class MockURLSession: URLSessionProtocol {
    
    let data: Data?
    let responseCode: URLResponse?
    let error: Error?
    
    init (data: Data?, responseCode: URLResponse?, error: Error?){
        self.data = data
        self.responseCode = responseCode
        self.error = error
    }
   
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        completionHandler(data, responseCode, error)
        return MockURLSessionDataTask()
    }
    
    func dataTask(with request: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        completionHandler(data, responseCode, error)
        return MockURLSessionDataTask()
    }
    
}
