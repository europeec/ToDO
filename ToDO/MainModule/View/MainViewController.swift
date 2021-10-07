//
//  MainViewController.swift
//  ToDO
//
//  Created by Дмитрий Юдин on 06.10.2021.
//

import UIKit

class MainViewController: UIViewController {
    var presenter: MainModuleViewPresenterProtocol!
    
    @IBOutlet weak var tableView: UITableView!
    
    var calendarView: UIView = {
        let calendar = UIDatePicker()
        calendar.datePickerMode = .date
        calendar.preferredDatePickerStyle = .compact
        calendar.addTarget(self, action: #selector(changeDate), for: .valueChanged)
        return calendar
    }()
    
    var floatingButton = CircleButton(size: ElementSize.FloatingButton.side.rawValue,
                                      color: .white, label: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: calendarView)
        tableView.register(MainTableViewCell.nib, forCellReuseIdentifier: MainTableViewCell.identifier)
        
        floatingButton.addTarget(self, action: #selector(tapOnTheButton), for: .touchUpInside)
        self.view.addSubview(floatingButton)
    }
    
    @objc func changeDate(sender: UIDatePicker) {
        self.presenter.changeDate(new: sender.date)
    }
    
    @objc func tapOnTheButton() {
        presenter.tapOnAddButton()
    }
}

extension MainViewController: MainModuleViewProtocol {
    func loading() {
        self.tableView?.backgroundColor = .red
    }
    
    func empty() {
        self.tableView?.backgroundColor = .blue
    }
    
    func show() {
        //
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else { fatalError() }
        cell.titleLabel.text = String(indexPath.row)
        cell.descriptionLabel.text = String("oooohhh")
        return cell
    }
}
