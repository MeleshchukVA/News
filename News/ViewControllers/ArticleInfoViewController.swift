//
//  ArticleInfoViewController.swift
//  News
//
//  Created by Владимир Мелещук on 31.03.2022.
//

import UIKit
import SafariServices

class ArticleInfoViewController: NewsDataLoadingViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let stackView = UIStackView()
    var imageView = NewsImageView(frame: .zero)
    let titleLabel = NewsTitleLabel(textAlignment: .left, fontSize: 20)
    let descriptionLabel = NewsTitleLabel(textAlignment: .left, fontSize: 15)
    let authorLabel = NewsBodyLabel(textAlignment: .left)
    let dateLabel = NewsBodyLabel(textAlignment: .left)
    let sourceButton = NewsButton(color: .systemBlue, title: "Источник")
    
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
        configureScrollView()
        layoutUI()
        configureUIElements()
        configureStackView()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(dismssVC))
        navigationItem.rightBarButtonItem = doneButton
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.leftBarButtonItem = addButton
    }
    
    @objc func dismssVC() {
        dismiss(animated: true)
    }
    
    @objc func addButtonTapped() {
        showLoadingView()
        
        NetworkManager.shared.getArticleInfo { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let bookmark):
                self.addArticleToBookmarks(bookmark: bookmark)
                
            case .failure(let error):
                self.presentNewsAlert(title: "Что-то пошло не так.", message: error.rawValue, buttonTitle: "Ок")
            }
        }
    }
    
    func addArticleToBookmarks(bookmark: [Article]) {
        let bookmark = Article(title: article.title, url: article.url)
        
        PersistenceManager.updateWith(bookmark: bookmark, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else {
                self.presentNewsAlert(title: "Добавлено!", message: "Вы добавили эту новость в закладки.", buttonTitle: "Ок")
                return
            }
            self.presentNewsAlert(title: "Что-то пошло не так.", message: error.rawValue, buttonTitle: "Ок")
        }
    }
    
    func configureUIElements() {
        imageView.downloadImage(fromURL: article.urlToImage ?? UrlStrings.placeholderUrlImage)
        
        titleLabel.text = article.title
        titleLabel.numberOfLines = 4
        
        descriptionLabel.text = article.description ?? "Читайте подробности на сайте."
        descriptionLabel.numberOfLines = 5
        
        authorLabel.text = article.author ?? "Автор не указан."
        authorLabel.numberOfLines = 1
        authorLabel.lineBreakMode = .byTruncatingTail
        
        sourceButton.addTarget(self, action: #selector(sourceButtonTapped), for: .touchUpInside)
        
        dateLabel.text = (article.publishedAt?.convertToDisplayFormat() ?? "N/A")
    }
    
    @objc func sourceButtonTapped() {
        presentSafariVC(for: article)
    }
    
    func presentSafariVC(for article: Article) {
        guard let url = URL(string: article.url ?? UrlStrings.urlNotFound) else {
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)

        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 700)
        ])
    }
    
    func configureStackView() {
        stackView.axis = .vertical
        stackView.distribution = .equalCentering

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(authorLabel)
        stackView.addArrangedSubview(dateLabel)
        
        let padding: CGFloat = 20
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),

            authorLabel.topAnchor.constraint(equalTo: descriptionLabel.text == "" ? titleLabel.bottomAnchor : descriptionLabel.bottomAnchor, constant: padding),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),

            dateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
        ])
    }
    
    func layoutUI() {
        let padding: CGFloat = 20
        
        contentView.addSubview(imageView)
        contentView.addSubview(stackView)
        contentView.addSubview(sourceButton)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 280),
            
            sourceButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: padding),
            sourceButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            sourceButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            sourceButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
