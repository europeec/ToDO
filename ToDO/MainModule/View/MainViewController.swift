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

    let calendarView: UIDatePicker = {
        let calendar = UIDatePicker()
        calendar.datePickerMode = .date
        calendar.preferredDatePickerStyle = .compact
        return calendar
    }()

    let floatingButton = CircleButton(size: ElementSize.FloatingButton.side.rawValue,
                                      color: .white, label: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: calendarView)
        
        tableView.register(MainTableViewCell.nib, forCellReuseIdentifier: MainTableViewCell.identifier)

        calendarView.addTarget(self, action: #selector(changeDate), for: .valueChanged)
        
        floatingButton.addTarget(self, action: #selector(tapOnTheButton), for: .touchUpInside)
        self.view.addSubview(floatingButton)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.fetchTasks(at: presenter.date)
    }

    
    @objc func changeDate(sender: UIDatePicker) {
        print(sender.date)
        presenter.changeDate(new: sender.date)
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
            
            // reloadSection for use withAnimation, can use just reloadData() without animation
            self.tableView.reloadSections(IndexSet(integer: 0), with: .middle)
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
