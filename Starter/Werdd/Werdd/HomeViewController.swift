//
//  ViewController.swift
//  Werdd
//
//  Created by Han Kim on 2/21/22.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    
    let appTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Werdd."
        label.font = UIFont(name: "Rubik-SemiBold", size: 32)
        return label
    }()
    
    let blueView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "WerddBlue")
        view.layer.cornerRadius = 20
        return view
    }()
    
    let wordTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Programming"
        label.font = UIFont(name: "Rubik-Bold", size: 24)
        return label
    }()
    
    let partsOfSpeechLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "noun"
        label.font = UIFont(name: "Rubik-Italic", size: 14)
        return label
    }()
    
    let wordDefinitionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "creating a sequence of instructions to enable the computer to do something"
        label.font = UIFont(name: "Rubik-Regular", size: 12)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "Taupe")
        
        addSubviews()
        addConstraints()
    }
    
    // MARK: - UI Setup
    
    func addSubviews() {
        view.addSubview(appTitleLabel)
        view.addSubview(blueView)
        blueView.addSubview(wordTitleLabel)
        blueView.addSubview(partsOfSpeechLabel)
        blueView.addSubview(wordDefinitionLabel)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            appTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            appTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            appTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor),
            
            blueView.topAnchor.constraint(equalTo: appTitleLabel.bottomAnchor, constant: 30),
            blueView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            blueView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            blueView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            
            wordTitleLabel.topAnchor.constraint(equalTo: blueView.topAnchor, constant: 20),
            wordTitleLabel.leadingAnchor.constraint(equalTo: blueView.leadingAnchor, constant: 20),
            
            partsOfSpeechLabel.topAnchor.constraint(equalTo: wordTitleLabel.topAnchor, constant: 8),
            partsOfSpeechLabel.leadingAnchor.constraint(equalTo: wordTitleLabel.trailingAnchor, constant: 5),
            partsOfSpeechLabel.trailingAnchor.constraint(lessThanOrEqualTo: blueView.trailingAnchor),
            
            wordDefinitionLabel.topAnchor.constraint(equalTo: partsOfSpeechLabel.bottomAnchor, constant: 20),
            wordDefinitionLabel.leadingAnchor.constraint(equalTo: wordTitleLabel.leadingAnchor),
            wordDefinitionLabel.trailingAnchor.constraint(equalTo: blueView.trailingAnchor, constant: -20)
        ])
    }
}

