//
//  RoundedViewWithColor.swift
//  Werdd
//
//  Created by Han Kim on 2/21/22.
//

import UIKit

class RoundedViewWithColor: UIView {
    
    // MARK: - Properties
    
    var completion: (() -> Void)?
    
    let wordTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Rubik-Bold", size: 24)
        return label
    }()
    
    let partsOfSpeechLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Rubik-Italic", size: 14)
        return label
    }()
    
    let wordDefinitionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Rubik-Light", size: 18)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    lazy var refreshButton: RefreshButton = {
        let button = RefreshButton { [weak self] in
            self?.completion?()
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initializer
    
    init(completion: (()-> Void)?) {
        self.completion = completion
        
        super.init(frame: .zero)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setUpUI() {
        backgroundColor = UIColor(named: "WerddBlue")
        layer.cornerRadius = 20
        
        setUpWordTitle()
        setUpPartsOfSpeech()
        setUpDefinition()
        setUpRefreshButton()
    }
    
    func setUpWordTitle() {
        addSubview(wordTitleLabel)
        
        NSLayoutConstraint.activate([
            wordTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            wordTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
    }
    
    func setUpPartsOfSpeech() {
        addSubview(partsOfSpeechLabel)
        
        NSLayoutConstraint.activate([
            partsOfSpeechLabel.bottomAnchor.constraint(equalTo: wordTitleLabel.bottomAnchor, constant: -4),
            partsOfSpeechLabel.leadingAnchor.constraint(equalTo: wordTitleLabel.trailingAnchor, constant: 5),
            partsOfSpeechLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor)
        ])
    }
    
    func setUpDefinition() {
        addSubview(wordDefinitionLabel)
        
        NSLayoutConstraint.activate([
            wordDefinitionLabel.topAnchor.constraint(equalTo: partsOfSpeechLabel.bottomAnchor, constant: 20),
            wordDefinitionLabel.leadingAnchor.constraint(equalTo: wordTitleLabel.leadingAnchor),
            wordDefinitionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    func setUpRefreshButton() {
        addSubview(refreshButton)
        
        NSLayoutConstraint.activate([
            refreshButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            refreshButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}

