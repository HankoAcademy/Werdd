//
//  DefinitionDetailsViewController.swift
//  Werdd
//
//  Created by Hannie Kim on 4/16/22.
//

import UIKit

final class DefinitionDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    let wordDetail: WordDetail
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
            descriptionText: wordDetail.definition
        )
        wordDetailsView.translatesAutoresizingMaskIntoConstraints = false
        return wordDetailsView
    }()
    
    lazy var synonymsView: WordDetailsView = {
        let hideSynonyms = wordDetail.synonyms == nil
        
        let synonymsText = wordDetail.synonyms?.joined(separator: ", ")
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
        let hideAntonyms = wordDetail.antonyms == nil
        
        let antonymsText = wordDetail.antonyms?.joined(separator: ", ")
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
        let hideExamples = wordDetail.examples == nil
        
        let examplesText = wordDetail.examples?.joined(separator: "\n\n")
        
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
    
    // MARK: - Initializers
    
    init(wordDetail: WordDetail, selectedWord: String) {
        self.wordDetail = wordDetail
        self.selectedWord = selectedWord
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

        navigationItem.title = selectedWord
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
