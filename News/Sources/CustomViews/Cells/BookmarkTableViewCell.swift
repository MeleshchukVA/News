//
//  BookmarkTableViewCell.swift
//  News
//
//  Created by Владимир Мелещук on 04.04.2022.
//

import UIKit

final class BookmarkTableViewCell: UITableViewCell {
    
    static let reuseID = "BookmarkCell"
    let titleLabel = NewsTitleLabel(textAlignment: .left, fontSize: 18)
    let newsImageView = NewsImageView(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell(bookmark: Article) {
        titleLabel.text = bookmark.title
        newsImageView.downloadImage(fromURL: bookmark.urlToImage ?? UrlStrings.placeholderUrlImage)
    }

    private func configure() {
        addSubviews(titleLabel, newsImageView)

        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12

        NSLayoutConstraint.activate([
            newsImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            newsImageView.heightAnchor.constraint(equalToConstant: 60),
            newsImageView.widthAnchor.constraint(equalToConstant: 60),
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
