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
    
    static var buttonSide: CGFloat = 70
    var floatingButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: buttonSide, height: buttonSide))
        button.layer.cornerRadius = buttonSide / 2
        button.layer.shadowRadius = 8
        if let image = UIImage(systemName: "plus.circle") {
            button.imageView?.contentMode = .scaleAspectFit
            button.setImage(image, for: .normal)
        }
        button.layer.shadowOpacity = 0.3
        button.backgroundColor = .orange
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapOnTheButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: calendarView)
        tableView.register(MainTableViewCell.nib, forCellReuseIdentifier: MainTableViewCell.identifier)
        self.view.addSubview(floatingButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        floatingButton.widthAnchor.constraint(equalToConstant: MainViewController.buttonSide).isActive = true
        floatingButton.heightAnchor.constraint(equalToConstant: MainViewController.buttonSide).isActive = true
        floatingButton.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -20).isActive = true
        floatingButton.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor, constant: 0).isActive = true
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
