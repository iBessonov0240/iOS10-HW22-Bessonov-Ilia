//
//  UserDetailsTableViewCell.swift
//  iOS10-HW22-Bessonov Ilia
//
//  Created by i0240 on 16.09.2023.
//

import UIKit

class UserDetailsWithButtonCell: SimpleCell {

//    var person: Person? {
//        didSet {
//
//        }
//    }

    // MARK: - Outlets

    private lazy var otherButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Other", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
//        self.person = nil
    }

    // MARK: - Setup

    private func setupHierarchy() {
        contentView.addSubview(otherButton)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            otherButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            otherButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
}
