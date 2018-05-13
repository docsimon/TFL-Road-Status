//
//  DetailViewController.swift
//  TFLRoadStatus
//
//  Created by doc on 12/05/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var searchItem: String?
    var detailViewModel: DetailViewModel?
    var errorManager = ErrorManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        errorManager.delegate = self
        if let searchItem = searchItem {
            detailViewModel = DetailViewModel(searchItem: searchItem)
            detailViewModel?.delegate = self
            detailViewModel?.fetchData()
        }
    }

}

extension DetailViewController: DetailViewModelProtocol {
    func updateUIWithData(data: Road) {
        
    }
    
    func displayError(errorData: ErrorData) {
        
    }
    
    
}

extension DetailViewController: ErrorControllerProtocol {
    func dismissActivityControl() {
        
    }
    
    func presentError(alertController: UIAlertController) {
        present(alertController, animated: true)
    }
    
    func fetchData() {
        detailViewModel?.fetchData()
    }
    
    
}
