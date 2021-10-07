//
//  ToggleTableViewCell.swift
//  ToDO
//
//  Created by Дмитрий Юдин on 07.10.2021.
//

import UIKit

class ToggleTableViewCell: UITableViewCell {
    static let identifier = "ToggleTableViewCell"
    static let nib = UINib(nibName: identifier, bundle: nil)

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var toggle: UISwitch! {
        didSet {
            // можно использовать IBAction
            toggle.addTarget(self, action: #selector(toggleSwitch), for: .valueChanged)
        }
    }

    // for checking toggle
    var presenter: AddModuleViewPresenterProtocol!

    @objc func toggleSwitch(sender: UISwitch) {
        presenter.toggle()
    }
}
