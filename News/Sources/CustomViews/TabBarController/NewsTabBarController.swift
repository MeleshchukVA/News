//
//  NewsTabBarController.swift
//  News
//
//  Created by Владимир Мелещук on 31.03.2022.
//

import UIKit

class NewsTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemBlue
        viewControllers = [createNewsNavigationController(), createBookmarksNavigationController()]
    }

    func createNewsNavigationController() -> UINavigationController {
        let newsListViewController = NewsListViewController()
        newsListViewController.tabBarItem = UITabBarItem(
            title: "Новости",
            image: UIImage(systemName: "newspaper"),
            tag: 0
        )

        return UINavigationController(rootViewController: newsListViewController)
    }

    func createBookmarksNavigationController() -> UINavigationController {
        let bookmarksListViewController = BookmarksListViewController()
        bookmarksListViewController.tabBarItem = UITabBarItem(
            title: "Закладки",
            image: UIImage(systemName: "book"),
            tag: 0
        )

        return UINavigationController(rootViewController: bookmarksListViewController)
    }
}
