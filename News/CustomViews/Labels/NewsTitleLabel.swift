//
//  NewsTitleLabel.swift
//  News
//
//  Created by Владимир Мелещук on 31.03.2022.
//

import UIKit

class NewsTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // сonvenience позволяет не вызывать дважды функцию configure() в override и в init.
    // Также позволяет установить дефолтные значения для init.
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }

    private func configure() {
        textColor = .label
        numberOfLines = 4
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail // Чтобы были точки, если надпись длинная.
        translatesAutoresizingMaskIntoConstraints = false
    }
}
