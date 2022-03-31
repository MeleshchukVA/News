//
//  NewsListViewController.swift
//  News
//
//  Created by Владимир Мелещук on 31.03.2022.
//

import UIKit

class NewsListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "News"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
