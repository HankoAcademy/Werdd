//
//  RoundedViewWithColor.swift
//  Werdd
//
//  Created by Han Kim on 2/21/22.
//

import UIKit

class RoundedViewWithColor: UIView {

    let color: UIColor?
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
        label.font = UIFont(name: "Helvetica-Oblique", size: 14)
        return label
    }()

    let wordDefinitionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Rubik-Light", size: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    lazy var refreshButton: RefreshButton = {
        let button = RefreshButton { [weak self] in
            self?.completion?()
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    init(color: UIColor?, frame: CGRect = .zero, completion: (() -> Void)?) {
        self.completion = completion
        self.color = color

        super.init(frame: frame)

        setUpUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpUI() {
        backgroundColor = color
        layer.cornerRadius = 20
        setUpSubviews()
    }

    func setUpSubviews() {

        addSubview(wordTitleLabel)
        addSubview(partsOfSpeechLabel)
        addSubview(wordDefinitionLabel)
        addSubview(refreshButton)

        NSLayoutConstraint.activate([
            wordTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            wordTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            wordTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: partsOfSpeechLabel.leadingAnchor),

            partsOfSpeechLabel.topAnchor.constraint(equalTo: wordTitleLabel.topAnchor, constant: 8),
            partsOfSpeechLabel.leadingAnchor.constraint(equalTo: wordTitleLabel.trailingAnchor, constant: 5),
            partsOfSpeechLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20),

            wordDefinitionLabel.topAnchor.constraint(equalTo: partsOfSpeechLabel.bottomAnchor, constant: 20),
            wordDefinitionLabel.leadingAnchor.constraint(equalTo: wordTitleLabel.leadingAnchor),
            wordDefinitionLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20),

            refreshButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            refreshButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            refreshButton.widthAnchor.constraint(equalTo: refreshButton.heightAnchor)
        ])
    }
}
