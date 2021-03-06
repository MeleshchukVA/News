//
//  UIViewController+Extension.swift
//  News
//
//  Created by Владимир Мелещук on 04.04.2022.
//

import UIKit

extension UIViewController {
    
    // Функция отображает NewsAlert.
    func presentNewsAlert(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertViewController = NewsAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
            alertViewController.modalPresentationStyle = .overFullScreen
            alertViewController.modalTransitionStyle = .crossDissolve
            self.present(alertViewController, animated: true)
        }
    }
}
