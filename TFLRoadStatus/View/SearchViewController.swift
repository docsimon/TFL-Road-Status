//
//  SearchViewController.swift
//  TFLRoadStatus
//
//  Created by doc on 12/05/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchField: UITextField!
    var errorManager = ErrorManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        errorManager.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? DetailViewController {
            destVC.searchItem = searchField.text
        }
    }
   
    @IBAction func searchAction(_ sender: Any) {
        guard searchField.text?.isEmpty == false else {
            errorManager.displayError(errorTitle: Constants.Errors.errorEmptyFieldTitle, errorMsg: Constants.Errors.errorEmptyFieldMsg)
            return
        }
        performSegue(withIdentifier: "search", sender: nil)
            
        
    }
}
// MARK: Error Protocol
extension SearchViewController: ErrorControllerProtocol {
    func dismissActivityControl() {
        // unused here
    }
    
    func presentError(alertController: UIAlertController) {
        present(alertController, animated: true)
    }
    
    func fetchData() {
        //unused here
    }
    
    
}
