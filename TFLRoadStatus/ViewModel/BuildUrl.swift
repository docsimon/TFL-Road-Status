//
//  BuildUrl.swift
//  TFLRoadStatus
//
//  Created by doc on 12/05/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import Foundation

class BuildUrl{
    let searchItem: String
    let basePath: String
    
    init(searchItem: String, basePath: String){
        self.searchItem = searchItem
        self.basePath = basePath
    }
    
    func getUrl() -> URL?{
        var urlComponents = URLComponents(string: Constants.Client.baseUrl)
        urlComponents?.path = basePath + "/" + searchItem
        urlComponents?.queryItems = [
            URLQueryItem(name: Constants.TflParameterKeys.AppID, value: Constants.TflParameterValues.AppID),
            URLQueryItem(name: Constants.TflParameterKeys.AppKey, value: Constants.TflParameterValues.AppKey)
        ]
        
        let url = urlComponents?.url
        debugPrint(url?.absoluteString)
        return url
    }
}
