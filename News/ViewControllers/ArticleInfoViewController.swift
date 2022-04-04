//
//  ArticleInfoViewController.swift
//  News
//
//  Created by Владимир Мелещук on 31.03.2022.
//

import UIKit

class ArticleInfoViewController: UIViewController {
    
    var article: Article!
    
    init(article: Article) {
        super.init(nibName: nil, bundle: nil)
        self.article = article
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismssVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func dismssVC() {
        dismiss(animated: true)
    }
}
