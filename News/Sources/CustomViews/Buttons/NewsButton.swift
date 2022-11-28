//
//  NewsButton.swift
//  News
//
//  Created by Владимир Мелещук on 31.03.2022.
//

import UIKit

final class NewsButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Задаем кастомные цвет и тайтл кнопки.
    convenience init(color: UIColor, title: String) {
        self.init(frame: .zero)
        set(color: color, title: title)
    }

    // Задаем постояные свойства кнопки: внешний вид (configuration) и cornerStyle.
    private func configure() {
        configuration = .tinted()
        configuration?.cornerStyle = .medium
        translatesAutoresizingMaskIntoConstraints = false
    }

    // Задаем все кастомные настройки.
    private func set(color: UIColor, title: String) {
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = color
        configuration?.title = title
    }
}
