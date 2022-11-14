//
//  DefinitionDetailsViewController.swift
//  Werdd
//
//  Created by Hannie Kim on 4/16/22.
//

import UIKit

final class DefinitionDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    let wordDetail: Word
    let selectedWord: String
    
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
            partsOfSpeech: wordDetail.partOfSpeech,
            description: wordDetail.definition
        )
        wordDetailsView.translatesAutoresizingMaskIntoConstraints = false
        return wordDetailsView
    }()
    
    lazy var synonymsView: WordDetailsView = {
        // if there are no synonyms, hide this whole view from displaying
        let hideSynonyms = wordDetail.synonyms == nil
        
        // display synonyms separated by comma and a space
        let synonymsText = wordDetail.synonyms?.joined(separator: ", ")
        
        let wordDetailsView = WordDetailsView(
            isHidden: hideSynonyms,
            backgroundColor: UIColor(named: "WerddGreen"),
            title: "Synonyms",
            partsOfSpeech: nil,
            description: synonymsText
        )
        wordDetailsView.translatesAutoresizingMaskIntoConstraints = false
        return wordDetailsView
    }()
    
    lazy var antonymsView: WordDetailsView = {
        // if there are no antonyms, hide this whole view from displaying
        let hideAntonyms = wordDetail.antonyms == nil
        
        // display antonyms separated by comma and a space
        let antonymsText = wordDetail.antonyms?.joined(separator: ", ")
        
        let wordDetailsView = WordDetailsView(
            isHidden: hideAntonyms,
            backgroundColor: UIColor(named: "WerddPink"),
            title: "Antonyms",
            partsOfSpeech: nil,
            description: antonymsText
        )
        wordDetailsView.translatesAutoresizingMaskIntoConstraints = false
        return wordDetailsView
    }()
    
    lazy var examplesView: WordDetailsView = {
        // if there are no examples, hide this whole view from displaying
        let hideExamples = wordDetail.examples == nil
        
        // display examples separated by two new lines
        let examplesText = wordDetail.examples?.joined(separator: "\n\n")
        
        let wordDetailsView = WordDetailsView(
            isHidden: hideExamples,
            backgroundColor: UIColor(named: "Creamsicle"),
            title: "Example Usage",
            partsOfSpeech: nil,
            description: examplesText
        )
        wordDetailsView.translatesAutoresizingMaskIntoConstraints = false
        return wordDetailsView
    }()
    
    // MARK: - Initializers
    
    init(wordDetail: Word, selectedWord: String) {
        self.wordDetail = wordDetail
        self.selectedWord = selectedWord
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "Taupe")
        
        setUpUI()
        setUpNavigation()
    }
    
    // MARK: - UI Setup
    
    private func setUpNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes

        navigationItem.title = wordDetail.name
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
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func addStackViews() {
        contentStackView.addArrangedSubview(definitionView)
        contentStackView.addArrangedSubview(synonymsView)
        contentStackView.addArrangedSubview(antonymsView)
        contentStackView.addArrangedSubview(examplesView)
        
        // fills up any extra space to expand contentStackView to the height of scrollView
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
