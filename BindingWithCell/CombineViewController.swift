//
//  CombineViewController.swift
//  BindingWithCell
//
//  Created by Makeeyaf on 2021/01/16.
//

import UIKit
import Combine

final class CombineViewController: UIViewController {
    var data: [Setting] = [
        Setting(title: "Notification"),
        Setting(title: "DarkMode"),
        Setting(title: "Email Subscription"),
    ]

    private var bag: Set<AnyCancellable> = []

    // MARK: Views

    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(CombineCell.self, forCellReuseIdentifier: CombineCell.reuseID)
        view.delegate = self
        view.dataSource = self
        return view
    }()

    // MARK: Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setConstraints()
    }

    private func addViews() {
        view.addSubview(tableView)
    }

    private func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension CombineViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CombineCell.reuseID, for: indexPath) as! CombineCell

        cell.titleLabel.text = data[indexPath.row].title
        cell.toggleSwitch.isOn = data[indexPath.row].isOn

        cell.$isOn.dropFirst()
            .removeDuplicates()
            .subscribe(on: DispatchQueue.main)
            .sink { [weak self] isOn in
                self?.data[indexPath.row].isOn = isOn
                self?.tableView.reloadData()
            }
            .store(in: &bag)
        return cell
    }
}
