//
//  RxViewController.swift
//  BindingWithCell
//
//  Created by Makeeyaf on 2021/01/15.
//

import UIKit
import RxSwift
import RxCocoa

final class RxViewController: UIViewController {
    var data: [Setting] = [
        Setting(title: "Notification"),
        Setting(title: "DarkMode"),
        Setting(title: "Email Subscription"),
    ]

    private var disposeDict: [UUID: Disposable] = [:]

    // MARK: Views

    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(RxCell.self, forCellReuseIdentifier: RxCell.reuseID)
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

extension RxViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RxCell.reuseID, for: indexPath) as! RxCell

        cell.titleLabel.text = data[indexPath.row].title
        cell.toggleSwitch.isOn = data[indexPath.row].isOn

        let id = data[indexPath.row].id
        disposeDict[id]?.dispose()
        disposeDict[id] = cell.toggleSwitch.rx.isOn.changed.asDriver()
            .distinctUntilChanged()
            .drive(onNext: { [weak self] isOn in
                self?.data[indexPath.row].isOn = isOn
                self?.tableView.reloadData()
            })

        return cell
    }
}
