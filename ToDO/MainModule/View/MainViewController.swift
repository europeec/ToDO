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
        presenter.fetchTasks(for: presenter.date)
        
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
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            print(self.presenter.tasks)
            self.tableView.reloadData()
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.tasks?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier,
                                                       for: indexPath) as? MainTableViewCell else { fatalError() }
        guard let task = presenter.tasks?[indexPath.row] else { fatalError("task not created?")}
        cell.titleLabel.text = task.name
        cell.descriptionLabel.text = task.about
        return cell
    }
}
