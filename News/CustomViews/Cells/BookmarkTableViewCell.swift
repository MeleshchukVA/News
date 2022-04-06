//
//  BookmarkTableViewCell.swift
//  News
//
//  Created by Владимир Мелещук on 04.04.2022.
//

import UIKit

class BookmarkTableViewCell: UITableViewCell {
    static let reuseID = "BookmarkCell"
    let titleLabel = NewsTitleLabel(textAlignment: .left, fontSize: 18)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell(bookmark: Article) {
        titleLabel.text = bookmark.title
    }

    private func configure() {
        addSubviews(titleLabel)

        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12

        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
