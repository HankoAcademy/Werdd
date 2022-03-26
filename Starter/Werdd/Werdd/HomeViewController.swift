//
//  ViewController.swift
//  Werdd
//
//  Created by Han Kim on 2/7/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    let appTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Werdd."
        label.font = UIFont(name: "Rubik-SemiBold", size: 32)
        return label
    }()
    
    let blueView: RoundedViewWithColor = {
        let view = RoundedViewWithColor(color: UIColor(named: "WerddBlue"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        label.font = UIFont(name: "Rubik-Light", size: 12)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var refreshButton: RefreshButton = {
        let button = RefreshButton { [weak self] in
            self?.refreshRandomWordLabels()
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let words = [
        Word(name: "antelope chipmunk", definition: "small ground squirrel of western United States", partOfSpeech: "noun"),
        Word(name: "auricular artery", definition: "artery that supplies blood to the ear", partOfSpeech: "noun"),
        Word(name: "electric circuit", definition: "an electrical device that provides a path for electrical current to flow", partOfSpeech: "noun"),
        Word(name: "punic", definition: "of or relating to or characteristic of ancient Carthage or its people or their language", partOfSpeech: "adjective"),
        Word(name: "glib", definition: "artfully persuasive in speech", partOfSpeech: "adjective"),
        Word(name: "appetite", definition: "a feeling of craving something", partOfSpeech: "noun"),
        Word(name: "authoritatively", definition: "in an authoritative and magisterial manner", partOfSpeech: "adverb"),
        Word(name: "golf links", definition: "a golf course that is built on sandy ground near a shore", partOfSpeech: "noun"),
        Word(name: "unsay", definition: "take back what one has said", partOfSpeech: "verb"),
        Word(name: "unbarreled", definition: "not in a barrel", partOfSpeech: "adjective")
    ]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "Taupe")
        
        addSubviews()
        refreshRandomWordLabels()
    }
    
    // MARK: - UI Setup
    
    func addSubviews() {
        view.addSubview(appTitleLabel)
        view.addSubview(blueView)
        blueView.addSubview(wordTitleLabel)
        blueView.addSubview(partsOfSpeechLabel)
        blueView.addSubview(wordDefinitionLabel)
        blueView.addSubview(refreshButton)
        
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
            wordTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: partsOfSpeechLabel.leadingAnchor),
            
            partsOfSpeechLabel.topAnchor.constraint(equalTo: wordTitleLabel.topAnchor, constant: 8),
            partsOfSpeechLabel.leadingAnchor.constraint(equalTo: wordTitleLabel.trailingAnchor, constant: 5),
            partsOfSpeechLabel.trailingAnchor.constraint(lessThanOrEqualTo: blueView.trailingAnchor, constant: -20),
            
            wordDefinitionLabel.topAnchor.constraint(equalTo: partsOfSpeechLabel.bottomAnchor, constant: 20),
            wordDefinitionLabel.leadingAnchor.constraint(equalTo: wordTitleLabel.leadingAnchor),
            wordDefinitionLabel.trailingAnchor.constraint(lessThanOrEqualTo: blueView.trailingAnchor, constant: -20),
            
            refreshButton.trailingAnchor.constraint(equalTo: blueView.trailingAnchor, constant: -10),
            refreshButton.bottomAnchor.constraint(equalTo: blueView.bottomAnchor, constant: -10),
            refreshButton.widthAnchor.constraint(equalTo: refreshButton.heightAnchor)
        ])
    }
    
    // MARK: - Actions
    
    func refreshRandomWordLabels() {
        let randomWord = words.randomElement()
        wordTitleLabel.text = randomWord?.name
        partsOfSpeechLabel.text = randomWord?.partOfSpeech
        wordDefinitionLabel.text = randomWord?.definition
    }
}
