//
//  NewsEmptyStateView.swift
//  News
//
//  Created by Владимир Мелещук on 04.04.2022.
//

import UIKit

class NewsEmptyStateView: UIView {
    
    let messageLabel = NewsTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }

    private func configure() {
        addSubviews(messageLabel, logoImageView)
        configureMessageLabel()
        configureLogoImageView()
    }

    private func configureMessageLabel() {
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel

//        let labelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -90 : -150

        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func configureLogoImageView() {
        logoImageView.image = UIImage(systemName: "books.vertical", withConfiguration: UIImage.SymbolConfiguration(hierarchicalColor: .systemGray4))
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

//        let logoBottomConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 80 : 40

        NSLayoutConstraint.activate([
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
