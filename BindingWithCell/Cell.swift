//
//  Cell.swift
//  BindingWithCell
//
//  Created by Makeeyaf on 2021/01/15.
//

import UIKit

final class RxCell: UITableViewCell {
    static let reuseID = String(describing: self)

    // MARK: Views

    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = .systemFont(ofSize: 16, weight: .semibold)
        return view
    }()

    lazy var toggleSwitch = UISwitch()

    // MARK: Lifecycles

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addViews()
        setConstraints()
    }

    private func addViews() {
        [titleLabel, toggleSwitch].forEach {
            contentView.addSubview($0)
        }
    }

    private func setConstraints() {
        [titleLabel, toggleSwitch].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: toggleSwitch.leadingAnchor),
        ])

        NSLayoutConstraint.activate([
            toggleSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            toggleSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}


final class CombineCell: UITableViewCell {
    static let reuseID = String(describing: self)

    @Published var isOn: Bool = true

    // MARK: Views

    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = .systemFont(ofSize: 16, weight: .semibold)
        return view
    }()

    lazy var toggleSwitch: UISwitch = {
        let view = UISwitch()
        view.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        return view
    }()

    // MARK: Lifecycles

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addViews()
        setConstraints()
    }

    private func addViews() {
        [titleLabel, toggleSwitch].forEach {
            contentView.addSubview($0)
        }
    }

    private func setConstraints() {
        [titleLabel, toggleSwitch].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: toggleSwitch.leadingAnchor),
        ])

        NSLayoutConstraint.activate([
            toggleSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            toggleSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }

    // MARK: Actions

    @objc private func switchValueChanged(_ sender: UISwitch) {
        isOn = sender.isOn
    }
}
