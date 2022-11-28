//
//  ArticleInfoViewController.swift
//  News
//
//  Created by Владимир Мелещук on 31.03.2022.
//

import UIKit
import SafariServices

final class ArticleInfoViewController: NewsDataLoadingViewController {
    
    // MARK: Properties
    let scrollView = UIScrollView()
    let contentView = UIView()
    let labelsStackView = UIStackView()
    var imageView = NewsImageView(frame: .zero)
    let titleLabel = NewsTitleLabel(textAlignment: .left, fontSize: 20)
    let descriptionLabel = NewsTitleLabel(textAlignment: .left, fontSize: 15)
    let authorLabel = NewsBodyLabel(textAlignment: .left)
    let dateLabel = NewsBodyLabel(textAlignment: .left)
    let sourceButton = NewsButton(color: .systemBlue, title: "Источник")
    var article: Article!
    
    // MARK: Initializers
    
    init(article: Article) {
        super.init(nibName: nil, bundle: nil)
        self.article = article
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureScrollView()
        configureLayout()
        configureUIElements()
        configureStackView()
    }
}

// MARK: - Private extension

private extension ArticleInfoViewController {
    
    // MARK: Methods
    func configureViewController() {
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(dismssVC))
        navigationItem.rightBarButtonItem = doneButton
        
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .bookmarks,
            target: self,
            action: #selector(addButtonTapped)
        )
        navigationItem.leftBarButtonItem = addButton
    }
    
    func addArticleToBookmarks(bookmark: [Article]) {
        let bookmark = Article(title: article.title, url: article.url)
        
        PersistenceManager.updateWith(bookmark: bookmark, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else {
                self.presentNewsAlert(
                    title: "Добавлено",
                    message: "Вы добавили эту новость в закладки.",
                    buttonTitle: "Ок"
                )
                return
            }
            self.presentNewsAlert(
                title: "Что-то пошло не так",
                message: error.rawValue,
                buttonTitle: "Ок"
            )
        }
    }
    
    func configureUIElements() {
        imageView.downloadImage(fromURL: article.urlToImage ?? UrlStrings.placeholderUrlImage)
        titleLabel.text = article.title
        descriptionLabel.text = article.description ?? "Читайте подробности на сайте."
        authorLabel.text = article.author ?? "Автор не указан"
        dateLabel.text = (article.publishedAt?.convertToDisplayFormat() ?? "N/A")
        sourceButton.addTarget(self, action: #selector(sourceButtonTapped), for: .touchUpInside)
    }
    
    func presentSafariVC(for article: Article) {
        guard let url = URL(string: article.url ?? UrlStrings.urlNotFound) else { return }
        
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
        labelsStackView.axis = .vertical
        labelsStackView.distribution = .equalCentering

        labelsStackView.addSubviews(titleLabel, descriptionLabel, authorLabel, dateLabel)
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: labelsStackView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),

            authorLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: padding),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),

            dateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
        ])
    }
    
    func configureLayout() {
        contentView.addSubviews(imageView, labelsStackView, sourceButton)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            labelsStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
            labelsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            labelsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            labelsStackView.heightAnchor.constraint(equalToConstant: 300),
            
            sourceButton.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: padding),
            sourceButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            sourceButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            sourceButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: Actions
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
                self.presentNewsAlert(title: "Что-то пошло не так", message: error.rawValue, buttonTitle: "Ок")
            }
        }
    }
    
    @objc func sourceButtonTapped() {
        presentSafariVC(for: article)
    }
}
