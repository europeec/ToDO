//
//  TextFieldTableViewCell.swift
//  ToDO
//
//  Created by Дмитрий Юдин on 07.10.2021.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
    static let identifier = "TextFieldTableViewCell"
    static let nib = UINib(nibName: identifier, bundle: nil)

    @IBOutlet weak var textField: UITextField!

    var presenter: AddModuleViewPresenterProtocol!
    var type: CellsConfiguration?
    
    @IBAction func edit(_ sender: UITextField) {
        guard let type = type else { return }
        if type == .textFieldName {
            presenter.editName(sender.text)
        } else if type == .textFieldDescription {
            presenter.editDescription(sender.text)
        }

        textField.resignFirstResponder()
    }
}
