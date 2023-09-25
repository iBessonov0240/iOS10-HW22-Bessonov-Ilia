//
//  SimpleCell.swift
//  iOS10-HW22-Bessonov Ilia
//
//  Created by i0240 on 18.09.2023.
//

import UIKit

class SimpleCell: UITableViewCell {

//    var items: UserDetailsItems? {
//        didSet {
//            iconImageView.image = items?.icon
//        }
//    }

    // MARK: - Outlets

    private lazy var conteinerView: UIView = {
        let view = UIView()
        view.tintColor = .systemGray
        view.clipsToBounds = true
//        view.layer.cornerRadius = 5
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var infoTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.tintColor = .systemBlue
        textField.textAlignment = .left
//        textField.attributedPlaceholder = NSAttributedString(string: "Print your name here", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray2, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
//        textField.backgroundColor = .systemGray6
//        textField.layer.cornerRadius = 10
//        textField.clipsToBounds = true
//        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textField.frame.height))
//        textField.leftView = leftView
//        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
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
        contentView.addSubviews(conteinerView, iconImageView, infoTextField)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            conteinerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19),
            conteinerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            conteinerView.widthAnchor.constraint(equalToConstant: 27),
            conteinerView.heightAnchor.constraint(equalToConstant: 27),

            iconImageView.topAnchor.constraint(equalTo: conteinerView.topAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor),
            iconImageView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor),

            infoTextField.heightAnchor.constraint(equalToConstant: 40),
            infoTextField.widthAnchor.constraint(equalToConstant: 120),
            infoTextField.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 15),
        ])
    }
}
