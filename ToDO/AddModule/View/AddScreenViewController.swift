//
//  AddScreenViewController.swift
//  ToDO
//
//  Created by Дмитрий Юдин on 06.10.2021.
//

import UIKit

class AddScreenViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TextFieldTableViewCell.nib, forCellReuseIdentifier: TextFieldTableViewCell.identifier)
        tableView.register(ToggleTableViewCell.nib, forCellReuseIdentifier: ToggleTableViewCell.identifier)
        tableView.register(DatePickerTableViewCell.nib, forCellReuseIdentifier: DatePickerTableViewCell.identifier)
        
        
    }
}


// MARK: - UITableViewDataSource, UITableViewDelegate
extension AddScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if 0...1 ~= section {
            let headerType = section == 0 ? TitleForSection.naming : TitleForSection.date
            return headerType.title
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let type = getTypeForIndexPath(indexPath) else { return .zero }
        if type == .textFieldDescription {
            return self.view.frame.size.height * 0.3
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let type = getTypeForIndexPath(indexPath) else { return UITableViewCell() }
        
        switch type {
        case .textFieldName, .textFieldDescription:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.identifier, for: indexPath) as? TextFieldTableViewCell else { fatalError("Cann't create TextFieldCell") }
            cell.textField.placeholder = type.text
            return cell
        case .toggle:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ToggleTableViewCell.identifier, for: indexPath) as? ToggleTableViewCell else { fatalError("Cann't create ToggleCell") }
            cell.label.text = type.text
            return cell
        case .startDate, .endDate:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DatePickerTableViewCell.identifier, for: indexPath) as? DatePickerTableViewCell else { fatalError("Cann't create DatePickerCell") }
            cell.label.text = type.text
            return cell
        }
    }
    

    
}

//extension AddScreenViewController: UITextFieldDelegate, UIDatePickerDele
