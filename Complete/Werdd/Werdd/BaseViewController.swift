//
//  BaseViewController.swift
//  Werdd
//
//  Created by Hannie Kim on 4/24/22.
//

import UIKit

class BaseViewController: UIViewController {

    let spinnerViewController = SpinnerViewController()
    
    /// Shows loading indicator 
    func addSpinner() {
        addChild(spinnerViewController)
        spinnerViewController.view.frame = view.frame
        view.addSubview(spinnerViewController.view)
        spinnerViewController.didMove(toParent: self)
    }
    
    // Removes loading indicator
    func removeSpinner() {
        spinnerViewController.willMove(toParent: nil)
        spinnerViewController.view.removeFromSuperview()
        spinnerViewController.removeFromParent()
    }
    
    func presentGenericErrorAlert() {
        let alertController = UIAlertController(title: "Error", message: "Unexpected error occurred. Please try again later 🏗️", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alertController, animated: true)
    }
}
