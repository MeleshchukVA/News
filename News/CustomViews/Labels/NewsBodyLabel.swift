//
//  NewsBodyLabel.swift
//  News
//
//  Created by Владимир Мелещук on 31.03.2022.
//

import UIKit

class NewsBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }

    private func configure() {
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byTruncatingTail
        numberOfLines = 1
        translatesAutoresizingMaskIntoConstraints = false
    }
}
