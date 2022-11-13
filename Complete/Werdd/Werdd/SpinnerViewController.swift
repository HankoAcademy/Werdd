//
//  SpinnerViewController.swift
//  Werdd
//
//  Created by Hannie Kim on 4/24/22.
//

import UIKit

final class SpinnerViewController: UIViewController {
    
    let spinner: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        
        view.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
