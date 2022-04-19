//
//  WordDetailView.swift
//  Werdd
//
//  Created by Hannie Kim on 4/18/22.
//

import Foundation
import UIKit

class WordDetailView: UIView {
    
    // MARK: - UI Setup
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 20
        return stackView
    }()
    
    let descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let partsOfSpeechLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.isHidden = true
        label.textAlignment = .left
        label.font = UIFont(name: "Rubik-SemiBoldItalic", size: 12)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont(name: "Rubik-Medium", size: 20)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Rubik-Bold", size: 14)
        return label
    }()
    
    // MARK: - Property Observers
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var partOfSpeech: String? {
        didSet {
            partsOfSpeechLabel.text = partOfSpeech
        }
    }
    
    var details: String? {
        didSet {
            descriptionLabel.text = details
        }
    }
    
    // MARK: - Initializers
    
    init(backgroundColor: UIColor? = .white) {
        super.init(frame: .zero)
        
        self.backgroundColor = backgroundColor
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    func setUpViews() {
        partsOfSpeechLabel.isHidden = true // hidden by default
        layer.cornerRadius = 20
        addDescriptionStackView()
        addTitleLabel()
        addStackView()
    }
    
    func addDescriptionStackView() {
        descriptionStackView.addArrangedSubview(partsOfSpeechLabel)
        descriptionStackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(descriptionStackView)
    }
    
    func addTitleLabel() {
        stackView.addArrangedSubview(titleLabel)
    }
    
    func addStackView() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    func showPartsOfSpeech() {
        partsOfSpeechLabel.isHidden = false
    }
}
