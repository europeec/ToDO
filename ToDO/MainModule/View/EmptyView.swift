//
//  EmptyView.swift
//  ToDO
//
//  Created by Дмитрий Юдин on 20.10.2021.
//

import UIKit

class EmptyView: UIView {
    lazy private var imageView: UIImageView = {
        let image = UIImage(named: "cat")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var isPresenting = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView.frame = self.bounds
    }
    
    func present(view: UIView) {
        view.addSubview(self)
        fadeIn()
    }
    
    func dismiss() {
        if isPresenting {
            fadeOut()
        }
    }
    
    private func fadeIn() {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
            self.alpha = 0.5
        }) { _ in
            self.addSubview(self.imageView)
            self.isPresenting = true
        }
    }
    
    private func fadeOut() {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
            self.alpha = 0.0
        }) { _ in
            self.removeFromSuperview()
            self.isPresenting = false
        }
    }
}
