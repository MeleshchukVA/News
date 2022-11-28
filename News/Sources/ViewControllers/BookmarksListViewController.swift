//
//  BookmarksListViewController.swift
//  News
//
//  Created by Владимир Мелещук on 31.03.2022.
//

import UIKit
import SafariServices

class BookmarksListViewController: NewsDataLoadingViewController {
    
    // MARK: - Properties.
    
    let tableView = UITableView()
    var bookmarks: [Article] = []
    
    // MARK: - Lifecycle.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getBookmarks()
    }
    
    // MARK: - Private methods.
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Закладки"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        view.addSubview(tableView)

        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BookmarkTableViewCell.self, forCellReuseIdentifier: BookmarkTableViewCell.reuseID)
        tableView.removeExcessCells()
    }

    private func getBookmarks() {
        PersistenceManager.retrieveBookmarks { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let bookmarks):
                self.updateUI(with: bookmarks)

            case .failure(let error):
                self.presentNewsAlert(title: "Что-то пошло не так", message: error.rawValue, buttonTitle: "Ок")
            }
        }
    }

    private func updateUI(with bookmarks: [Article]) {
        if bookmarks.isEmpty {
            self.showEmptyStateView(with: "Здесь отображаются ваши закладки.", in: self.view)
        } else {
            self.bookmarks = bookmarks
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)
            }
        }
    }
}

// MARK: - UITableViewDataSource.

extension BookmarksListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: BookmarkTableViewCell.reuseID
        ) as? BookmarkTableViewCell else {
            let cell = BookmarkTableViewCell(
                style: .default,
                reuseIdentifier: BookmarkTableViewCell.reuseID
            )
            return cell
        }
        let bookmark = bookmarks[indexPath.row]
        cell.setupCell(bookmark: bookmark)
        return cell
    }
}

// MARK: - UITableViewDelegate.

extension BookmarksListViewController: UITableViewDelegate {
    
    // При нажатии на ячейку отображается SafariViewController.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bookmark = bookmarks[indexPath.row]
        guard let url = URL(string: bookmark.url ?? UrlStrings.urlNotFound) else { return }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true)
    }

    // Swipe to delete.
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard editingStyle == .delete else { return }

        PersistenceManager.updateWith(bookmark: bookmarks[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                self.bookmarks.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            self.presentNewsAlert(title: "Не можем удалить закладку", message: error.rawValue, buttonTitle: "Ок")
        }
        
        // Отображает EmptyStateView, когда все ячейки удалены.
        if bookmarks.isEmpty {
            showEmptyStateView(with: "Здесь отображаются ваши закладки.", in: self.view)
        }
    }
}
