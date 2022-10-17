//
//  HomeViewController.swift
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
    
    lazy var randomWordView: RoundedViewWithColor = {
        let view = RoundedViewWithColor { [weak self] in
            self?.refreshRandomWordLabels()
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        
        setUpUI()
        refreshRandomWordLabels()
    }
    
    // MARK: - UI Setup
    
    func setUpUI() {
        setUpAppTitleLabel()
        setUpRandomWordView()
    }
    
    func setUpAppTitleLabel() {
        view.addSubview(appTitleLabel)
        
        NSLayoutConstraint.activate([
            appTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            appTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            appTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor),
        ])
    }
    
    func setUpRandomWordView() {
        view.addSubview(randomWordView)
        
        NSLayoutConstraint.activate([
            randomWordView.topAnchor.constraint(equalTo: appTitleLabel.bottomAnchor, constant: 30),
            randomWordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            randomWordView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            randomWordView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
        ])
    }
    
    // MARK: - Actions
    
    func refreshRandomWordLabels() {
        let randomWord = words.randomElement()
        randomWordView.wordTitleLabel.text = randomWord?.name
        randomWordView.partsOfSpeechLabel.text = randomWord?.partOfSpeech
        randomWordView.wordDefinitionLabel.text = randomWord?.definition
    }
}
