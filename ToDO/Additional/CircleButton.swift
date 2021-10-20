//
//  Extension UIButton.swift
//  ToDO
//
//  Created by Дмитрий Юдин on 07.10.2021.
//

import UIKit

class CircleButton: UIButton {
    init(size: CGFloat, color: UIColor, type: CircleButtonType) {
        super.init(frame: .zero)

        self.layer.cornerRadius = size / 2
        self.layer.shadowRadius = 8
        self.layer.shadowColor = UIColor.shadowColor.cgColor
        if let image = UIImage(systemName: type.rawValue) {
            self.setImage(image, for: .normal)
            self.contentVerticalAlignment = .fill
            self.contentHorizontalAlignment = .fill
            self.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 15, right: 15)
        }
        self.layer.shadowOpacity = 0.25
        self.backgroundColor = color
        self.translatesAutoresizingMaskIntoConstraints = false

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard let view = self.superview else { return }

        self.widthAnchor.constraint(equalToConstant: ElementSize.FloatingButton.side.rawValue).isActive = true
        self.heightAnchor.constraint(equalToConstant: ElementSize.FloatingButton.side.rawValue).isActive = true
        self.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor,
                                     constant: ElementSize.FloatingButton.bottomPadding.rawValue).isActive = true
        self.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor,
                                       constant: ElementSize.FloatingButton.trailingPadding.rawValue).isActive = true
    }
}


enum CircleButtonType: String {
    case add = "plus.circle"
    case accept = "checkmark.circle"
}
