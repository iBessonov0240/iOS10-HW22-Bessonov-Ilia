//
//  UsersViewController.swift
//  iOS10-HW22-Bessonov Ilia
//
//  Created by i0240 on 12.09.2023.
//

import UIKit

class UsersViewController: UIViewController {

    private var presenter: UserPresenter?
    private var items: [Person]?

    // MARK: - Outlets

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.tintColor = .systemBlue
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(string: "Print your name here", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray2, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textField.frame.height))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.setAttributedTitle(NSAttributedString(string: "Press", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = UserPresenter(userView: self, person: items)
        setupHierarchy()
        setupLayout()
        fetchPeople()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }

    // MARK: - Setup

    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func fetchPeople() {
        presenter?.fetchPeople()
    }

    private func setupHierarchy() {
        view.addSubview(tableView)
        view.addSubview(textField)
        view.addSubview(button)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 45),

            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            button.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            button.heightAnchor.constraint(equalTo: textField.heightAnchor),

            tableView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - Actions

    @objc func buttonTapped() {
        if textField.text != "" {
            guard let context = presenter?.context else { return }
            // Create a person object
            let newPerson = Person(context: context)
            newPerson.name = textField.text
            newPerson.age = "01.04.1976"
            newPerson.gender = "Gender"
            textField.text = ""
            
            presenter?.savePeople()
        } else {
            let alert = UIAlertController(title: "Nothing was written",
                                          message: "Please enter the name in textField",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            self.present(alert, animated: true)
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension UsersViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let person = self.items?[indexPath.row]

        cell.textLabel?.text = person?.name
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = UsersDetailsViewController()
        tableView.deselectRow(at: indexPath, animated: true)
        viewController.person = self.items?[indexPath.row]
        viewController.updateInformation = { [weak self] in
            self?.fetchPeople()
        }
        navigationController?.pushViewController(viewController, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Create swipe action
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in

            // Which person to remove
            let personToRemove = self.items?[indexPath.row]

            // Remove the person
            self.presenter?.deletePeople(personToRemove)

            // Save the data
            self.presenter?.savePeople()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}

// MARK: - UserViewProtocol

extension UsersViewController: UserView {

    func showPeople(_ people: [Person]) {
        self.items = people
        tableView.reloadData()
    }

    func reloadTableView() {
        tableView.reloadData()
    }

    func deletePerson(_ people: [Person]) {
        self.items = people
        tableView.reloadData()
    }
}
