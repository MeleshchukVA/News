//
//  NewsListTableViewCell.swift
//  News
//
//  Created by Владимир Мелещук on 01.04.2022.
//

import UIKit

class NewsListTableViewCell: UITableViewCell {
    
    let stackView = UIStackView()
    let newsImageView = NewsImageView(frame: .zero)
    let newsTitleLabel = NewsTitleLabel(textAlignment: .left, fontSize: 18)
    
    static let reuseID = "NewsListCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell(article: Article) {
        newsImageView.downloadImage(fromURL: article.urlToImage ?? UrlStrings.placeholderUrlImage)
        newsTitleLabel.text = article.title
    }

    private func configure() {
        addSubviews(newsImageView, newsTitleLabel)

        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12

        NSLayoutConstraint.activate([
            newsImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            newsImageView.heightAnchor.constraint(equalToConstant: 100),
            newsImageView.widthAnchor.constraint(equalToConstant: 150),

            newsTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            newsTitleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 24),
            newsTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            newsTitleLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
