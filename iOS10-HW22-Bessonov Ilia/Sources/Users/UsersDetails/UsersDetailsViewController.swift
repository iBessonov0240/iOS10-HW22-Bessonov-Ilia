//
//  UsersDetailsViewController.swift
//  iOS10-HW22-Bessonov Ilia
//
//  Created by i0240 on 16.09.2023.
//

import UIKit

class UsersDetailsViewController: UIViewController {

    var person: Person?
    private var isEditingEnabled: Bool = false
    private var presenter: UserPresenter?
    var updateInformation: (() -> Void)?

    // MARK: - Outlets

    private lazy var personImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 80
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemBlue
        return imageView
    }()

    private lazy var personTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.tintColor = .black
        tableView.register(SimpleCell.self, forCellReuseIdentifier: "cell")
        tableView.register(UserDetailsWithButtonCell.self, forCellReuseIdentifier: "userDetails")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter = UserPresenter(userView: self)
        setupHierarchy()
        setupLayout()
        setupNavigationBar(title: "Edit")
    }

    // MARK: - Setup

    private func setupNavigationBar(title: String) {

        guard let navigationBar = navigationController?.navigationBar else { return }
        guard let navigationController = navigationController else  { return }

        navigationController.isNavigationBarHidden = false
        navigationBar.backgroundColor = .white

        let leftButton = UIButton()
        leftButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        leftButton.imageView?.contentMode = .scaleAspectFit
        leftButton.tintColor = .systemGray2
        leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let leftItem = UIBarButtonItem(customView: leftButton)
        navigationItem.leftBarButtonItem = leftItem
        navigationBar.prefersLargeTitles = false

        let rightButton = UIButton(type: .system)
        rightButton.setAttributedTitle(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]), for: .normal)
        rightButton.setTitleColor(.systemGray2, for: .normal)
        rightButton.clipsToBounds = true
        rightButton.layer.cornerRadius = 10
        rightButton.layer.borderWidth = 2
        rightButton.layer.borderColor = UIColor.black.cgColor
        rightButton.frame.size = CGSize(width: 80, height: 35)
        rightButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        let rightItem = UIBarButtonItem(customView: rightButton)
        navigationItem.rightBarButtonItem = rightItem
        navigationBar.prefersLargeTitles = false
    }

    private func setupHierarchy() {
        view.addSubviews(personImage, personTableView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            personImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            personImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            personImage.widthAnchor.constraint(equalToConstant: 160),
            personImage.heightAnchor.constraint(equalToConstant: 160),

            personTableView.topAnchor.constraint(equalTo: personImage.bottomAnchor, constant: 20),
            personTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            personTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            personTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - Actions

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func editButtonTapped() {
        isEditingEnabled.toggle()
        if isEditingEnabled {
            setupNavigationBar(title: "Save")
        } else {
            setupNavigationBar(title: "Edit")
            updateInformation?()
        }
        personTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension UsersDetailsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let item = UserDetailsItems.items[indexPath.row]

        switch(item.type) {
        case .name:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SimpleCell
            cell?.iconImageView.image = item.icon
            cell?.infoTextField.text = person?.name
            cell?.infoTextField.isEnabled = isEditingEnabled
            cell?.infoTextField.delegate = self
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        case .date:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SimpleCell
            cell?.iconImageView.image = item.icon
            cell?.infoTextField.text = person?.age
            cell?.infoTextField.isEnabled = isEditingEnabled
            cell?.infoTextField.delegate = self
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        case .gender:
            let cell = tableView.dequeueReusableCell(withIdentifier: "userDetails", for: indexPath) as? UserDetailsWithButtonCell
            cell?.iconImageView.image = item.icon
            cell?.infoTextField.text = person?.gender
            cell?.infoTextField.isEnabled = isEditingEnabled
            cell?.infoTextField.delegate = self
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        }
    }
}

// MARK: - UITextFieldDelegate
extension UsersDetailsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Обработка изменений в текстовых полях
        if let indexPath = personTableView.indexPathForRow(at: textField.convert(.zero, to: personTableView)) {
            let item = UserDetailsItems.items[indexPath.row]

            switch item.type {
            case .name:
                person?.name = textField.text
            case.date:
                person?.age = textField.text
            case .gender:
                person?.gender = textField.text
            }
            presenter?.savePeople()
        }
    }
}

// MARK: - UserViewProtocol

extension UsersDetailsViewController: UserView {
    func deletePerson(_ people: [Person]) {

    }

    func showPeople(_ people: [Person]) {
        for person in people {
            self.person = person
            personTableView.reloadData()
        }
    }

    func reloadTableView() {
        personTableView.reloadData()
    }
}
