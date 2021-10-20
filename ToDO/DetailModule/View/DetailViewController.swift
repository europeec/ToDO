//
//  DetailViewController.swift
//  ToDO
//
//  Created by Дмитрий Юдин on 20.10.2021.
//

import UIKit

class DetailViewController: UIViewController {
    var presenter: DetailPresenter!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView! {
        didSet {
            stackView.layer.cornerRadius = ElementSize.DetailStackLayer.cornerRadius.rawValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        show()
    }
}

extension DetailViewController: DetailViewProtocol {
    func show() {
        let task = presenter.task
        nameLabel.text = task.name
        descriptionLabel.text = task.about
        dateLabel.text = "\(task.startDate.getString()) - \(task.endDate.getString())"
    }
}
