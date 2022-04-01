//
//  WordTableViewCell.swift
//  Werdd
//
//  Created by Hannie Kim on 3/20/22.
//

import UIKit

class WordTableViewCell: UITableViewCell {

    // MARK: - Class Properties
    
    static let identifier = WordTableViewCell.self.description()
    
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
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let partsOfSpeechLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
                
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            
            partsOfSpeechLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 4),
            partsOfSpeechLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4),
            subtitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])
    }
    
    func updateViews(_ word: Word) {
        titleLabel.text = word.name
        subtitleLabel.text = word.definition
        partsOfSpeechLabel.text = word.partOfSpeech
    }
}
