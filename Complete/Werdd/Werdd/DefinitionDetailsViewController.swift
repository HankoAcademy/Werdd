//
//  DefinitionDetailsViewController.swift
//  Werdd
//
//  Created by Hannie Kim on 4/16/22.
//

import UIKit

class DefinitionDetailsViewController: UIViewController {

    let contentView: DefinitionDetailsView!
    let wordDetail: Word
    let selectedWord: String
    
    override func loadView() {
        view = contentView
    }
    
    init(wordDetail: Word, selectedWord: String) {
        self.wordDetail = wordDetail
        self.selectedWord = selectedWord
        self.contentView = DefinitionDetailsView(wordDetail: wordDetail, selectedWord: selectedWord)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes

        navigationItem.title = selectedWord
    }
}

class DefinitionDetailsView: UIView {

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
        let wordDetailsView = WordDetailsView()
        wordDetailsView.translatesAutoresizingMaskIntoConstraints = false
        wordDetailsView.infoTypeLabel.text = "Definition"
        wordDetailsView.descriptionLabel.text = wordDetail.definition
        wordDetailsView.partsOfSpeechLabel.text = wordDetail.partOfSpeech
        wordDetailsView.partsOfSpeechLabel.isHidden = false
        wordDetailsView.backgroundColor = .white
        return wordDetailsView
    }()
    
    lazy var synonymsView: WordDetailsView = {
        let wordDetailsView = WordDetailsView()
        wordDetailsView.translatesAutoresizingMaskIntoConstraints = false
        wordDetailsView.infoTypeLabel.textColor = .white
        wordDetailsView.infoTypeLabel.text = "Synonyms"
        wordDetailsView.isHidden = wordDetail.synonyms == nil
        wordDetailsView.descriptionLabel.text = wordDetail.synonyms?.joined(separator: ", ")
        wordDetailsView.backgroundColor = .lightGray
        return wordDetailsView
    }()
    
    lazy var antonymsView: WordDetailsView = {
        let wordDetailsView = WordDetailsView()
        wordDetailsView.translatesAutoresizingMaskIntoConstraints = false
        wordDetailsView.infoTypeLabel.textColor = .white
        wordDetailsView.infoTypeLabel.text = "Antonyms"
        wordDetailsView.isHidden = wordDetail.antonyms == nil
        wordDetailsView.descriptionLabel.text = wordDetail.antonyms?.joined(separator: ", ")
        wordDetailsView.backgroundColor = .gray
        return wordDetailsView
    }()
    
    lazy var exampleview: WordDetailsView = {
        let wordDetailsView = WordDetailsView()
        wordDetailsView.translatesAutoresizingMaskIntoConstraints = false
        wordDetailsView.infoTypeLabel.textColor = .white
        wordDetailsView.infoTypeLabel.text = "Example Usage"
        wordDetailsView.isHidden = wordDetail.examples == nil
        wordDetailsView.descriptionLabel.textColor = .lightGray
        wordDetailsView.descriptionLabel.text = wordDetail.examples?.joined(separator: "\n")
        wordDetailsView.backgroundColor = .darkGray
        return wordDetailsView
    }()
    
    let wordDetail: Word
    let selectedWord: String
    
    init(wordDetail: Word, selectedWord: String) {
        self.wordDetail = wordDetail
        self.selectedWord = selectedWord
        
        super.init(frame: .zero)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        
        backgroundColor = .black
                        
        contentStackView.addArrangedSubview(definitionView)
        contentStackView.addArrangedSubview(synonymsView)
        contentStackView.addArrangedSubview(antonymsView)
        contentStackView.addArrangedSubview(exampleview)
        
        let emptyView = UIView()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.addArrangedSubview(emptyView)
        
        scrollView.addSubview(contentStackView)
        
        addSubview(scrollView)
                
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}

class WordDetailsView: UIView {
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
//        stackView.distribution = .fillProportionally
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 20
        return stackView
    }()
    
    let descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let partsOfSpeechLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.isHidden = true
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    let infoTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        
        layer.cornerRadius = 20
        backgroundColor = .white
        
        descriptionStackView.addArrangedSubview(partsOfSpeechLabel)
        descriptionStackView.addArrangedSubview(descriptionLabel)
        
        stackView.addArrangedSubview(descriptionStackView)
        stackView.addArrangedSubview(infoTypeLabel)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
                                    
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            
            partsOfSpeechLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            descriptionStackView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            stackView.widthAnchor.constraint(equalTo: descriptionStackView.widthAnchor)
        ])
    }
}
