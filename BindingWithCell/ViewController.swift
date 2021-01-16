//
//  ViewController.swift
//  BindingWithCell
//
//  Created by Makeeyaf on 2021/01/15.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    // MARK: Views

    lazy var navigateToRxTableButton: UIButton = {
        let view = UIButton(type: .system)
        view.addTarget(self, action: #selector(rxTableButtonDidTapped), for: .touchUpInside)
        view.setTitle("RxTable", for: .normal)
        return view
    }()

    lazy var navigateToCombineTableButton: UIButton = {
        let view = UIButton(type: .system)
        view.addTarget(self, action: #selector(combineTableButtonDidTapped), for: .touchUpInside)
        view.setTitle("CombineTable", for: .normal)
        return view
    }()

    lazy var navigateToSwiftUITableButton: UIButton = {
        let view = UIButton(type: .system)
        view.addTarget(self, action: #selector(swiftUIButtonDidTapped), for: .touchUpInside)
        view.setTitle("SwiftUIList", for: .normal)
        return view
    }()

    lazy var contentStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            navigateToRxTableButton,
            navigateToCombineTableButton,
            navigateToSwiftUITableButton,
        ])
        view.axis = .vertical
        view.spacing = 10
        return view
    }()

    // MARK: Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setConstraints()
    }

    private func addViews() {
        view.addSubview(contentStack)
    }

    private func setConstraints() {
        contentStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            contentStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            contentStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    // MARK: Actions

    @objc private func rxTableButtonDidTapped() {
        let vc = RxViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func combineTableButtonDidTapped() {
        let vc = CombineViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func swiftUIButtonDidTapped() {
        let swiftUIListView = SwiftUIListView()
        let vc = UIHostingController(rootView: swiftUIListView)
        navigationController?.pushViewController(vc, animated: true)
    }

}

