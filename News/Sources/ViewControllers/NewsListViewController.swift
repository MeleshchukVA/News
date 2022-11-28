//
//  NewsListViewController.swift
//  News
//
//  Created by Владимир Мелещук on 31.03.2022.
//

import UIKit

class NewsListViewController: NewsDataLoadingViewController {
    
    // MARK: - Properties.

    let tableView = UITableView()
    var articles: [Article] = []
    var page = 1
    /// Если новостей больше заданного числа (20), принимает true.
    /// Если меньше - false.
    var hasMoreArticles = true
    /// Отключает постраничную загрузку, если не завершили запрос в сеть.
    /// Включает, если завершили.
    var isPaginating = false
    /// Отслеживает состояние UIRefreshControl.
    /// Если обновляем страницу с помощью pull to refresh, то принимает true.
    /// По окончании запроса в сеть принимает false.
    var isRefreshing = false
    
    // MARK: - Lifecycle.

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureTableView()
        getArticles(page: page)
    }
    
    // MARK: - Private methods.

    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Новости"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 120
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsListTableViewCell.self, forCellReuseIdentifier: NewsListTableViewCell.reuseID)
        
        configureRefreshControl()
    }
    
    private func configureRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    @objc private func didPullToRefresh() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        self.articles.removeAll()
        isRefreshing = true
        isPaginating = false
        hasMoreArticles = true
        page = 1
        
        getArticles(page: page)
    }
    
    private func getArticles(page: Int) {
        showLoadingView()
        isPaginating = true
        
        NetworkManager.shared.retrieveArticles(page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let articles):
                self.updateUI(with: articles)
                
            case .failure(let error):
                self.presentNewsAlert(title: "Что-то пошло не так", message: error.rawValue, buttonTitle: "Ок")
            }
            
            self.isPaginating = false
            self.isRefreshing = false
        }
    }
    
    private func updateUI(with articles: [Article]) {
        if articles.count < 20 { self.hasMoreArticles = false }
        self.articles.append(contentsOf: articles)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
            self.view.bringSubviewToFront(self.tableView)
        }
    }
}

// MARK: - UITableViewDataSource.

extension NewsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsListTableViewCell.reuseID
        ) as? NewsListTableViewCell else {
            let cell = NewsListTableViewCell(
                style: .default,
                reuseIdentifier: NewsListTableViewCell.reuseID
            )
            return cell
        }
        let article = articles[indexPath.row]
        // Отображаем в ячейке тайтл и картинку с помощью функции.
        cell.setupCell(article: article)
        return cell
    }
}

// MARK: - UITableViewDelegate.

extension NewsListViewController: UITableViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        // Постраничная загрузка.
        if offsetY > contentHeight - height {
            guard hasMoreArticles, !isPaginating else { return }
            page += 1
            isPaginating = true
            getArticles(page: page)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let article = articles[indexPath.row]
        let destinationViewController = ArticleInfoViewController(article: article)
        let navigationController = UINavigationController(rootViewController: destinationViewController)
        present(navigationController, animated: true)
    }
}
