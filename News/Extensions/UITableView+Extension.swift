//
//  UITableView+Extension.swift
//  News
//
//  Created by Владимир Мелещук on 04.04.2022.
//

import UIKit

extension UITableView {

    // Функция убирает лишние ячейки из tableView.
    func removeExcessCells() {
        tableFooterView = UIView.init(frame: .zero)
    }
}
