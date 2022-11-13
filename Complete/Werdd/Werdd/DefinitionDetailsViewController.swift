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
    
    lazy var definitionView: WordDetailView = {
        let wordDetailsView = WordDetailView(backgroundColor: UIColor(named: "WerddBlue"))
        wordDetailsView.translatesAutoresizingMaskIntoConstraints = false
        wordDetailsView.title = "Definition"
        wordDetailsView.partOfSpeech = wordDetail.partOfSpeech
        wordDetailsView.details = wordDetail.definition
        wordDetailsView.showPartsOfSpeech()
        return wordDetailsView
    }()
    
    lazy var synonymsView: WordDetailView = {
        let wordDetailsView = WordDetailView(backgroundColor: UIColor(named: "WerddGreen"))
        wordDetailsView.translatesAutoresizingMaskIntoConstraints = false
        wordDetailsView.title = "Synonyms"
        // if there are no synonyms, hide this whole view from displaying
        wordDetailsView.isHidden = wordDetail.synonyms == nil
        // display synonyms separated by comma and a space
        wordDetailsView.details = wordDetail.synonyms?.joined(separator: ", ")
        return wordDetailsView
    }()
    
    lazy var antonymsView: WordDetailView = {
        let wordDetailsView = WordDetailView(backgroundColor: UIColor(named: "WerddPink"))
        wordDetailsView.translatesAutoresizingMaskIntoConstraints = false
        wordDetailsView.title = "Antonyms"
        // if there are no antonyms, hide this whole view from displaying
        wordDetailsView.isHidden = wordDetail.antonyms == nil
        // display antonyms separated by comma and a space
        wordDetailsView.details = wordDetail.antonyms?.joined(separator: ", ")
        return wordDetailsView
    }()
    
    lazy var examplesView: WordDetailView = {
        let wordDetailsView = WordDetailView(backgroundColor: UIColor(named: "Creamsicle"))
        wordDetailsView.translatesAutoresizingMaskIntoConstraints = false
        wordDetailsView.title = "Example Usage"
        // if there are no examples, hide this whole view from displaying
        wordDetailsView.isHidden = wordDetail.examples == nil
        // display examples separated by two new lines
        wordDetailsView.details = wordDetail.examples?.joined(separator: "\n\n")
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
