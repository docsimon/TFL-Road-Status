//
//  DetailViewController.swift
//  TFLRoadStatus
//
//  Created by doc on 12/05/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var roadName: UILabel!
    @IBOutlet weak var roadStatus: UILabel!
    @IBOutlet weak var roadStatusDescription: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var searchItem: String?
    var detailViewModel: DetailViewModel?
    var errorManager = ErrorManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        errorManager.delegate = self
        if let searchItem = searchItem {
            detailViewModel = DetailViewModel(searchItem: searchItem)
            detailViewModel?.delegate = self
            detailViewModel?.fetchData()
//activityIndicator.activityIndicatorViewStyle =
        //        UIActivityIndicatorViewStyle.whiteLarge
            activityIndicator.startAnimating()
            bgView.isHidden = false
        }
    }

}

extension DetailViewController: DetailViewModelProtocol {
    func updateUIWithData(data: Road) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.bgView.isHidden = true
            self.roadName.text = data.displayName
            self.roadStatus.text = data.statusSeverity
            self.roadStatusDescription.text = data.statusSeverityDescription
        }
    }
    
    func displayError(errorData: ErrorData) {
        errorManager.displayError(errorTitle: errorData.errorTitle, errorMsg: errorData.errorMsg)
    }
    
    
}

extension DetailViewController: ErrorControllerProtocol {
    func dismissActivityControl() {
        activityIndicator.stopAnimating()
    }
    
    func presentError(alertController: UIAlertController) {
        present(alertController, animated: true)
    }
    
    func fetchData() {
        detailViewModel?.fetchData()
    }
    
    
}
