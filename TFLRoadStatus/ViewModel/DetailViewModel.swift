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
    }
    
    
}
