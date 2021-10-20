//
//  MainViewController.swift
//  ToDO
//
//  Created by Дмитрий Юдин on 06.10.2021.
//

import UIKit

class MainViewController: UIViewController {
    var presenter: MainModuleViewPresenterProtocol!
    var emptyView: EmptyView?

    @IBOutlet weak var tableView: UITableView!

    let calendarView: UIDatePicker = {
        let calendar = UIDatePicker()
        calendar.datePickerMode = .date
        calendar.preferredDatePickerStyle = .compact
        calendar.locale = Locale(identifier: "ru_RU")
        return calendar
    }()

    let floatingButton = CircleButton(size: ElementSize.FloatingButton.side.rawValue,
                                      color: .floatingButtonColor, type: .add
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: calendarView)
        
        tableView.register(MainTableViewCell.nib, forCellReuseIdentifier: MainTableViewCell.identifier)

        calendarView.addTarget(self, action: #selector(changeDate), for: .valueChanged)
        
        floatingButton.addTarget(self, action: #selector(tapOnTheButton), for: .touchUpInside)
        
        let side = min(view.frame.width, view.frame.height) * 0.7
        emptyView = EmptyView(frame: CGRect(x: 0, y: 0,
                                            width: side,
                                            height: side))
        self.view.addSubview(floatingButton)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        emptyView?.center = view.center
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
    func empty() {
        // TODO: - Empty View
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            UIView.animate(withDuration: 0.3) {
                self.tableView.alpha = 0
            } completion: { _ in
                self.tableView.isHidden = true
                self.tableView?.reloadData()
                self.emptyView?.present(view: self.view)
                
            }
        }
    }

    func show() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            UIView.animate(withDuration: 0.2) {
                self.tableView.alpha = 0
                self.emptyView?.dismiss()
            } completion: { _ in
                self.tableView.reloadData()
            }

            UIView.animate(withDuration: 0.3) {
                self.tableView.isHidden = false
                self.tableView?.alpha = 1
            } completion: { _ in
                if let index = self.presenter.tableData?.firstIndex, index != 0 {
                    let indexPath = IndexPath(row: 0, section: index)
                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                }
            }
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tasks = presenter.tableData?.sections[section].tasks else { return 0 }
        return tasks.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let tableData = presenter.tableData else { return 0 }
        return tableData.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.tableData?.sections[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier,
                                                       for: indexPath) as? MainTableViewCell else { fatalError() }
        guard let task = presenter.tableData?.sections[indexPath.section].tasks?[indexPath.row] else {
            fatalError("task not created?")
        }
        
        cell.titleLabel.text = task.name
        cell.descriptionLabel.text = task.about
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.presentDetailForIndexPath(indexPath)
    }
}
