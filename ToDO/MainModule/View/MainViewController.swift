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
    var calendarView: UIView {
        let calendar = UIDatePicker()
        calendar.datePickerMode = .date
        calendar.preferredDatePickerStyle = .compact
        calendar.addTarget(self, action: #selector(changeDate), for: .valueChanged)
        return calendar
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: calendarView)
    }
    
    @objc func changeDate(sender: UIDatePicker) {
        self.presenter.changeDate(new: sender.date)
    }
}

extension MainViewController: MainModuleViewProtocol {
    func loading() {
        //
    }
    
    func empty() {
        //
    }
    
    func show() {
        //
    }
}
