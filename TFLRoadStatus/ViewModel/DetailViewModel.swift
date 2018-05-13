//
//  DetailViewModel.swift
//  TFLRoadStatus
//
//  Created by doc on 12/05/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import Foundation

protocol DetailViewModelProtocol: class {
    func updateUIWithData(data: Road)
    //func updateUIWithErrorData(data: ErrorRoad)
    func displayError(errorData: ErrorData)
}

import Foundation

class DetailViewModel {
    let searchItem: String // this is the road to search
    weak var delegate: DetailViewModelProtocol? = nil
    
    init (searchItem: String){
        self.searchItem = searchItem
    }
    
    func fetchData() {
        let buildUrl = BuildUrl(searchItem: searchItem, basePath: Constants.Client.basePath)
        guard let url = buildUrl.getUrl() else {
            delegate?.displayError(errorData: ErrorData(errorTitle: Constants.Errors.urlPageErrorTitle, errorMsg: Constants.Errors.urlCreationErrorMsg))
            return
        }
        
        let client = Client()
        client.fetchRemoteData(request: url, completion: {data, error in
            
            guard error == nil else {
                self.delegate?.displayError(errorData: error!)
                return
            }

            if let data = data as? ErrorRoad{
                 self.delegate?.displayError(errorData: ErrorData(errorTitle: data.httpStatus, errorMsg: data.message))
                return
            }
            
            guard let data = data as? Road else {
                self.delegate?.displayError(errorData: ErrorData(errorTitle: Constants.Errors.errorDataTitle, errorMsg: Constants.Errors.errorReceivingData))
                return
            }
            
            self.delegate?.updateUIWithData(data: data)
            
        })
    }
}
