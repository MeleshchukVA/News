//
//  UIView+Extension.swift
//  News
//
//  Created by Владимир Мелещук on 01.04.2022.
//

import UIKit

extension UIView {
    
    // Функция может сразу добавить несколько subView в одну View.
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
