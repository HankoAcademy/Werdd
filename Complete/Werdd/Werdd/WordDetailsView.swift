//
//  WordDetailView.swift
//  Werdd
//
//  Created by Hannie Kim on 4/18/22.
//

import Foundation
import UIKit

final class WordDetailsView: UIView {
    
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
    
    // MARK: - Properties
    
    let title: String?
    let partsOfSpeech: String?
    let descriptionText: String?
    
    // MARK: - Initializers
    
    init(isHidden: Bool = false,
         backgroundColor: UIColor? = .white,
         title: String?,
         partsOfSpeech: String?,
         description: String?) {
                
        self.title = title
        self.partsOfSpeech = partsOfSpeech
        self.descriptionText = description
        
        super.init(frame: .zero)
        
        self.isHidden = isHidden
        self.backgroundColor = backgroundColor
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: - UI Setup
    
    private func setUpViews() {
        layer.cornerRadius = 20
        
        titleLabel.text = title
        partsOfSpeechLabel.text = partsOfSpeech
        descriptionLabel.text = descriptionText
        
        partsOfSpeechLabel.isHidden = partsOfSpeech == nil
        
        addDescriptionStackView()
        addTitleLabel()
        addStackView()
    }
    
    private func addDescriptionStackView() {
        descriptionStackView.addArrangedSubview(partsOfSpeechLabel)
        descriptionStackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(descriptionStackView)
    }
    
    private func addTitleLabel() {
        stackView.addArrangedSubview(titleLabel)
    }
    
    private func addStackView() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}
