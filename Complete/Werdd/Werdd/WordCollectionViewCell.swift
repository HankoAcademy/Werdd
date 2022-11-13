//
//  WordCollectionViewCell.swift
//  Werdd
//
//  Created by Hannie Kim on 3/20/22.
//

import UIKit

final class WordCollectionViewCell: UICollectionViewCell {

    // MARK: - Class Properties
    
    static let identifier = WordCollectionViewCell.self.description()
    
    // MARK: - UI Properties
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "Creamsicle")
        view.layer.cornerRadius = 20
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Rubik-Bold", size: 18)
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 4
        return label
    }()
    
    let partsOfSpeechLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Rubik-LightItalic", size: 12)
        return label
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setUpViews() {
        titleLabel.text = "title"
        partsOfSpeechLabel.text = "parts of speech"
        subtitleLabel.text = "subtitle"
        
        contentView.backgroundColor = .white
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(partsOfSpeechLabel)
        containerView.addSubview(subtitleLabel)
                
        contentView.addSubview(containerView)
        
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        partsOfSpeechLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            
            partsOfSpeechLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 4),
            partsOfSpeechLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            partsOfSpeechLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            subtitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -12)
        ])
    }
    
    func updateViews(_ wordDetail: WordDetail?, word: String?) {
        titleLabel.text = word
        subtitleLabel.text = wordDetail?.definition
        partsOfSpeechLabel.text = wordDetail?.partOfSpeech
    }
}
