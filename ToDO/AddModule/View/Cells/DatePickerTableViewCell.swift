//
//  DatePickerTableViewCell.swift
//  ToDO
//
//  Created by Дмитрий Юдин on 07.10.2021.
//

import UIKit

class DatePickerTableViewCell: UITableViewCell {
    static let identifier = "DatePickerTableViewCell"
    static let nib = UINib(nibName: identifier, bundle: nil)

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker! {
        didSet {
            datePicker.addTarget(self, action: #selector(changeDate(sender:)), for: .valueChanged)
        }
    }
    
    // For check change date
    var presenter: AddModuleViewPresenterProtocol!
    var type: CellsConfiguration?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func changeDate(sender: UIDatePicker) {
        presenter.changeDate(sender.date, type: type)
    }
}
