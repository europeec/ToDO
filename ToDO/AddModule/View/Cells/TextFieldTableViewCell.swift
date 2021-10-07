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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
