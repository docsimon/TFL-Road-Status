//
//  Client.swift
//  TFLRoadStatus
//
//  Created by doc on 12/05/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import Foundation
/*
 The responsibilities of the following class are:
 - Managing all the error related to the connection
 - Fetching data from the remote endpoint
 */

// This closure will be used as a callback for Authentication and Json data
typealias CompletionClosure<T> = ((T?, ErrorData?) -> ())

// This struct allowd to Decode json with the correct data type


class Client {
    
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol){
        self.session = session
    }
    func fetchRemoteData(request: URL, completion: @escaping CompletionClosure<Any>){
        
        // make the request
        session.dataTask(with: request, completionHandler: {(data, response, error) in
            
            // error checking
            guard (error == nil) else {
                let errorData = ErrorData(errorTitle: Constants.Errors.clientErrorTitle, errorMsg: (error?.localizedDescription) ?? "Error")
                completion(nil, errorData)
                return
                
            }
            // response checking
            let httpURLResponse = response as? HTTPURLResponse
            if let statusCode = httpURLResponse?.statusCode{
                guard (self.checkResponseCode(code: statusCode) == true) else {
                    let errorData = ErrorData(errorTitle: Constants.Errors.networkErrorTitle, errorMsg: "Status code: \(self.translateErrorResponseCode(code: statusCode))")
                    completion(nil, errorData)
                    return
                }
            }else {
                let errorData = ErrorData(errorTitle: Constants.Errors.networkErrorTitle, errorMsg: Constants.Errors.statusCodeUnknownMsg)
                completion(nil, errorData)
                return
            }
            // data checking
            guard let data = data else {
                let errorData = ErrorData(errorTitle: Constants.Errors.errorDataTitle, errorMsg: Constants.Errors.errorReceivingData)
                completion(nil, errorData)
                return
            }
            
            //  send data to correct destination
            switch httpURLResponse?.statusCode {
            case 404:
                let parsingResult: (ErrorRoad?, ErrorData?) = DataParser.parseJson(data: data)
                completion(parsingResult.0!, parsingResult.1)
                
            default: // success case
                let parsingResult: (Road?, ErrorData?) = DataParser.parseJson(data: data)
                completion(parsingResult.0, parsingResult.1)
            }
            
        }).resume()
        
    }
    
    private func checkResponseCode(code: Int) -> Bool {
        let successCode = [200, 201, 202, 203, 204, 304, 404]
        return successCode.contains(code)
    }
    
    private func translateErrorResponseCode (code: Int) -> String {
        switch code {
        case 400:
            return Constants.Errors.HttpError.http400
        case 403:
            return Constants.Errors.HttpError.http403
        case 404:
            return Constants.Errors.HttpError.http404
        case 408:
            return Constants.Errors.HttpError.http408
        case 410:
            return Constants.Errors.HttpError.http410
        case 429:
            return Constants.Errors.HttpError.http429
        case 500:
            return Constants.Errors.HttpError.http500
        case 502:
            return Constants.Errors.HttpError.http502
        case 503:
            return Constants.Errors.HttpError.http503
        case 504:
            return Constants.Errors.HttpError.http504
        default:
            return " \(code) \(Constants.Errors.HttpError.generic)"
        }
    }
    
}
