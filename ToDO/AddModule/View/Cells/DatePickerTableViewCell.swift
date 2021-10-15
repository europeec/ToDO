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
            datePicker.locale = Locale(identifier: "ru_RU")
        }
    }

    // For check change date
    var presenter: AddModuleViewPresenterProtocol?
    var type: CellsConfiguration?

    @objc func changeDate(sender: UIDatePicker) {
        presenter?.changeDate(sender.date, type: type)
    }
}
