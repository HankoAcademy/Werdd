//
//  DefinitionDetailsViewController.swift
//  Werdd
//
//  Created by Hanko Academy on 11/21/22.
//

import UIKit

class DefinitionDetailsViewController: UIViewController {

    // MARK: - Properties
    
    let word: Word
    
    // MARK: - UI Properties
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
        return stackView
    }()
    
    lazy var definitionView: WordDetailsView = {
        let wordDetailsView = WordDetailsView(
            backgroundColor: UIColor(named: "WerddBlue"),
            title: "Definition",
            partsOfSpeech: word.partOfSpeech,
            descriptionText: word.definition
        )
        wordDetailsView.translatesAutoresizingMaskIntoConstraints = false
        return wordDetailsView
    }()
    
    lazy var synonymsView: WordDetailsView = {
        let hideSynonyms = word.synonyms == nil
        
        let synonymsText = word.synonyms?.joined(separator: ", ")
        let wordDetailsView = WordDetailsView(
            isHidden: hideSynonyms,
            backgroundColor: UIColor(named: "WerddGreen"),
            title: "Synonyms",
            partsOfSpeech: nil,
            descriptionText: synonymsText
        )
        wordDetailsView.translatesAutoresizingMaskIntoConstraints = false
        
        return wordDetailsView
    }()
    
    lazy var antonymsView: UIView = {
        let hideAntonyms = word.antonyms == nil
        
        let antonymsText = word.antonyms?.joined(separator: ", ")
        let wordDetailsView = WordDetailsView(
            isHidden: hideAntonyms,
            backgroundColor: UIColor(named: "WerddPink"),
            title: "Antonyms",
            partsOfSpeech: nil,
            descriptionText: antonymsText
        )
        wordDetailsView.translatesAutoresizingMaskIntoConstraints = false
        
        return wordDetailsView
    }()
    
    lazy var examplesView: UIView = {
        let hideExamples = word.examples == nil
        
        let examplesText = word.examples?.joined(separator: "\n\n")
        
        let wordDetailsView = WordDetailsView(
            isHidden: hideExamples,
            backgroundColor: UIColor(named: "Creamsicle"),
            title: "Example Usage",
            partsOfSpeech: nil,
            descriptionText: examplesText
        )
        wordDetailsView.translatesAutoresizingMaskIntoConstraints = false
        
        return wordDetailsView
    }()
    
    // MARK: - Initializer
    
    init(word: Word) {
        self.word = word
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "Taupe")

        setUpNavigation()
        setUpUI()
    }
    
    // MARK: - UI Setup
    
    private func setUpNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        
        navigationItem.title = word.name
    }
    
    private func setUpUI() {
        addScrollView()
        addStackViews()
    }
    
    private func addScrollView() {
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func addStackViews() {
        contentStackView.addArrangedSubview(definitionView)
        contentStackView.addArrangedSubview(synonymsView)
        contentStackView.addArrangedSubview(antonymsView)
        contentStackView.addArrangedSubview(examplesView)
        
        let emptyView = UIView()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.addArrangedSubview(emptyView)
        
        scrollView.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            definitionView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor)
        ])
    }
}
