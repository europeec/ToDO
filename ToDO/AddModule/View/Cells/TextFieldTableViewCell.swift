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

}
