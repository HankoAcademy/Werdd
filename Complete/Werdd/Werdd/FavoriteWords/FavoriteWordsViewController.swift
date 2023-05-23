//
//  FavoriteWordsViewController.swift
//  Werdd
//
//  Created by Hannie Kim on 5/22/23.
//

import UIKit

final class FavoriteWordsViewController: UIViewController {

    // MARK: - Properties
    
    private let dataManager: DataManager
    private var favoriteWords: [FavoriteWord]?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(WordTableViewCell.self, forCellReuseIdentifier: WordTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Initializer
    
    init(dataManager: DataManager = DataManager()) {
        self.dataManager = dataManager
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        addSubviews()
        fetchFavoriteWords()
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func fetchFavoriteWords() {
        dataManager.fetchAllFavoriteWords { favoriteWords in
            self.favoriteWords = favoriteWords
        }
    }
}

extension FavoriteWordsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteWords?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let favoriteWord = favoriteWords?[indexPath.row] else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: WordTableViewCell.identifier, for: indexPath) as! WordTableViewCell
        
        cell.updateViews(with: favoriteWord)
        return cell
    }
}
