//
//  MainTableViewCell.swift
//  ToDO
//
//  Created by Дмитрий Юдин on 06.10.2021.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    static let identifier = "MainTableViewCell"
    static let nib = UINib(nibName: identifier, bundle: nil)

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
