//
//  ViewController.swift
//  Werdd
//
//  Created by Han Kim on 2/7/22.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    // MARK: - Properties
    
    let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    let appTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Werdd."
        label.font = UIFont(name: "Rubik-SemiBold", size: 32)
        return label
    }()
    
    lazy var favoritesListButton: UIButton = {
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .medium)
        let image = UIImage(systemName: "heart.text.square.fill", withConfiguration: symbolConfiguration)

        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = UIColor(named: "WerddPink")
        button.addTarget(self, action: #selector(favoritesListButtonPressed), for: .touchUpInside)
        return button
    }()

    lazy var randomWordView: RoundedViewWithColor = {
        let view = RoundedViewWithColor { [weak self] in
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
        collectionView.delegate = self
        collectionView.register(WordCollectionViewCell.self, forCellWithReuseIdentifier: WordCollectionViewCell.identifier)
        return collectionView
    }()
    
    lazy var searchView: SearchView = {
        let searchView = SearchView(searchDefinitionsDelegate: self)
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.layer.cornerRadius = 20

        // Top right corner, Top left corner
        searchView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return searchView
    }()
    
    private let networkManager: NetworkManager
    var words: [WordDetail]?
    var selectedWord: String?
    
    // MARK: - Initializer
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
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
        refreshRandomWordLabels()
    }
    
    // MARK: - UI Setup
    
    func setUpUI() {
        setUpHeader()
        setUpRandomWordView()
        setUpSearchView()
        setUpCollectionView()
    }
    
    func setUpHeader() {
        headerStackView.addArrangedSubview(appTitleLabel)
        headerStackView.addArrangedSubview(favoritesListButton)
        
        view.addSubview(headerStackView)
        
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    func setUpRandomWordView() {
        view.addSubview(randomWordView)
        
        NSLayoutConstraint.activate([
            randomWordView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 30),
            randomWordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            randomWordView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            randomWordView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
        ])
    }
    
    func setUpSearchView() {
        view.addSubview(searchView)
        
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: randomWordView.bottomAnchor, constant: 35),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func setUpCollectionView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Actions
    
    private func refreshRandomWordLabels() {
        addSpinner()
        
        networkManager.fetchRandomWord { [weak self] result in
            switch result {
            case .success(let randomWord):
                DispatchQueue.main.async {
                    self?.randomWordView.wordTitleLabel.text = randomWord.word
                    self?.randomWordView.partsOfSpeechLabel.text = randomWord.results?.first?.partOfSpeech
                    self?.randomWordView.wordDefinitionLabel.text = randomWord.results?.first?.definition
                    self?.removeSpinner()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.removeSpinner()
                }
                print(error.localizedDescription)
            }
        }
    }
    
    @objc func favoritesListButtonPressed() {
        navigationController?.pushViewController(FavoriteWordsViewController(), animated: true)
    }
}

// MARK: - UICollectionViewDataSource Methods

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return words?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WordCollectionViewCell.identifier, for: indexPath) as? WordCollectionViewCell else {
            return UICollectionViewCell()
        }
                    
        cell.configure(words?[indexPath.row], word: selectedWord)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate Methods

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedWord = selectedWord,
              let selectedWordDetails = words?[indexPath.row] else {
            assertionFailure("Selected word unexpectedly found nil")
            return
        }
        
        navigationController?.pushViewController(DefinitionDetailsViewController(wordDetail: selectedWordDetails, selectedWord: selectedWord), animated: true)
    }
}

// MARK: - SearchDefinitionDelegate Methods

extension HomeViewController: SearchDefinitionsDelegate {
    func searchDefinitions(forWord word: String?) {
        
        guard let word = word, !word.isEmpty else {
            // if there is no input in the textfield, prompt the user to enter one
            presentMissingWordAlert()
            return
        }
        
        addSpinner()
        
        networkManager.fetchWordWithDetails(word) { [weak self] result in
            switch result {
            case .success(let word):
                DispatchQueue.main.async {
                    let wordDetails = word.results
                    self?.words = wordDetails
                    self?.selectedWord = word.word
                    self?.collectionView.reloadData() // reloads the collectionView to use the updated `words` array values
                    self?.removeSpinner()
                }
            case .failure(let error):
                // good place to handle errors
                print("Failed to decode RandomWord with error: \(error.localizedDescription)")
                self?.removeSpinner()
            }
        }
    }
    
    // MARK: - Alerts
    
    private func presentMissingWordAlert() {
        let alertController = UIAlertController(
            title: "",
            message: "Please enter a word in the text field first to retrieve definitions",
            preferredStyle: .alert
        )
        alertController.addAction(
            UIAlertAction(
                title: "OK",
                style: .cancel,
                handler: nil)
        )
        present(alertController, animated: true, completion: nil)
    }
}
