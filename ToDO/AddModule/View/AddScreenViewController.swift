//
//  AddScreenViewController.swift
//  ToDO
//
//  Created by Дмитрий Юдин on 06.10.2021.
//

import UIKit

class AddScreenViewController: UIViewController {
    var presenter: AddModuleViewPresenterProtocol!
    @IBOutlet weak var tableView: UITableView!
    
    var floatingButton = CircleButton(size: ElementSize.FloatingButton.side.rawValue,
                                      color: .orange, label: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TextFieldTableViewCell.nib, forCellReuseIdentifier: TextFieldTableViewCell.identifier)
        tableView.register(ToggleTableViewCell.nib, forCellReuseIdentifier: ToggleTableViewCell.identifier)
        tableView.register(DatePickerTableViewCell.nib, forCellReuseIdentifier: DatePickerTableViewCell.identifier)
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
        floatingButton.addTarget(self, action: #selector(tapOnTheButton), for: .touchUpInside)
        self.view.addSubview(floatingButton)
    }
    
    @objc func tapOnTheButton() {
        presenter.save()
    }
}

// MARK: - AddModulePresenter
extension AddScreenViewController: AddModuleViewProtocol {
    func error() {
        // show alert
    }
    
    func reloadSetction() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let indexSet = IndexSet(integer: 1)
            self.tableView.reloadSections(indexSet, with: .none)
        }
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
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let type = getTypeForIndexPath(indexPath) else { fatalError("Cann`t undifine type of cell, indexPath: \(indexPath)") }
        
        switch type {
        case .textFieldName, .textFieldDescription:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.identifier, for: indexPath) as? TextFieldTableViewCell else { fatalError("Cann't create TextFieldCell")
            }
            cell.textField.placeholder = type.text
            return cell
            
        case .toggle:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ToggleTableViewCell.identifier, for: indexPath) as? ToggleTableViewCell else { fatalError("Cann't create ToggleCell") }
            cell.label.text = type.text
            cell.toggle.isOn = presenter.isAllDay
            cell.presenter = presenter
            return cell
            
        case .startDate, .endDate:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:      DatePickerTableViewCell.identifier, for: indexPath) as? DatePickerTableViewCell else { fatalError("Cann't create DatePickerCell")
            }
            
            cell.label.text = type.text
            cell.type = type
            cell.presenter = presenter
            cell.datePicker.date = type.date
            cell.datePicker.datePickerMode = presenter.isAllDay ? .date : .dateAndTime
            return cell
        }
    }
}
