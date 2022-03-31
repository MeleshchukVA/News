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
        newsListViewController.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "newspaper"), tag: 0)

        return UINavigationController(rootViewController: newsListViewController)
    }

    func createBookmarksNavigationController() -> UINavigationController {
        let bookmarksListViewController = BookmarksListViewController()
        bookmarksListViewController.title = "Bookmarks"
        bookmarksListViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)

        return UINavigationController(rootViewController: bookmarksListViewController)
    }
}
