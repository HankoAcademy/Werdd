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

    lazy var randomWordView: RoundedViewWithColor = {
        let view = RoundedViewWithColor(color: UIColor(named: "WerddBlue")) { [weak self] in
            self?.refreshRandomWordLabels()
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width/2.2, height: view.frame.size.width/3.5)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.register(WordTableViewCell.self, forCellWithReuseIdentifier: WordTableViewCell.identifier)
        return collectionView
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
        view.addSubview(randomWordView)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            appTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            appTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            appTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor),
            
            randomWordView.topAnchor.constraint(equalTo: appTitleLabel.bottomAnchor, constant: 30),
            randomWordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            randomWordView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            randomWordView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.20),
            
            collectionView.topAnchor.constraint(equalTo: randomWordView.bottomAnchor, constant: 35),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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

// MARK: - UICollectionViewDataSource Methods

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return words.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WordTableViewCell.identifier, for: indexPath) as? WordTableViewCell else {
            print("Expected WordTableViewCell but found nil")
            return UICollectionViewCell()
        }
                    
        cell.updateViews(words[indexPath.row])
        return cell
    }
}
