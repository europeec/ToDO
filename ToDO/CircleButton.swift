//
//  Extension UIButton.swift
//  ToDO
//
//  Created by Дмитрий Юдин on 07.10.2021.
//

import UIKit

class CircleButton: UIButton {
    init(size: CGFloat, color: UIColor, label: String) {
        super.init(frame: .zero)
        
        self.layer.cornerRadius = size / 2
        self.layer.shadowRadius = 8
        if let image = UIImage(systemName: "checkmark.circle") {
            self.imageView?.contentMode = .scaleAspectFit
            self.setImage(image, for: .normal)
        }
        self.layer.shadowOpacity = 0.3
        self.backgroundColor = color
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
