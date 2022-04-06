//
//  UIView+Extension.swift
//  News
//
//  Created by Владимир Мелещук on 01.04.2022.
//

import UIKit

extension UIView {
    
    // Фнукция распределяет view по всем экрану.
    func pinToEdges(of superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
    
    // Функция может сразу добавить несколько subView в одну View.
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
