//
//  DataParser.swift
//  TFLRoadStatus
//
//  Created by doc on 12/05/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import Foundation

typealias DataHandlerClosure<T: Decodable> = (Data) -> (T?, ErrorData?)

class DataParser {
    static func parseJson<T: Decodable>(data: Data) -> (T?, ErrorData?){
        let jsonDecoder = JSONDecoder()
        do {
            if T.self == Road.self {
               let jsonStruct = try jsonDecoder.decode([T].self, from: data)
                 return (jsonStruct[0], nil)
            }else {
               let jsonStruct = try jsonDecoder.decode(T.self, from: data)
                 return (jsonStruct, nil)
            }
        }catch {
            let errorData = ErrorData(errorTitle: Constants.Errors.errorDataTitle, errorMsg: error.localizedDescription)
            return (nil, errorData)
        }
       
    }
}
