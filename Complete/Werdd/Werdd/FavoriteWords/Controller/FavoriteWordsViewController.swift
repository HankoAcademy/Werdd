//
//  FavoriteWordsViewController.swift
//  Werdd
//
//  Created by Hannie Kim on 5/22/23.
//

import UIKit

final class FavoriteWordsViewController: BaseViewController {

    // MARK: - Properties
    
    private let dataManager: DataManager
    private var favoriteWords: [FavoriteWord]?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(WordTableViewCell.self, forCellReuseIdentifier: WordTableViewCell.identifier)
        tableView.separatorStyle = .none
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
    
    private func deleteFavoritedWord(_ word: FavoriteWord, atIndexPath indexPath: IndexPath) {
        do {
            try dataManager.deleteFavoriteWord(word)
            favoriteWords?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } catch {
            presentGenericErrorAlert()
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

extension FavoriteWordsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Delete", message: "Do you want to delete this werdd from your Favorites?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: .default) { _ in
            guard let favoriteWord = self.favoriteWords?[indexPath.row] else { return }
            
            self.deleteFavoritedWord(favoriteWord, atIndexPath: indexPath)
        })
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true, completion: nil)
    }
}
