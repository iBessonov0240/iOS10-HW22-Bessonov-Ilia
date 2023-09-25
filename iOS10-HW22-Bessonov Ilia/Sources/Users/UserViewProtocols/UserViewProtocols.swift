//
//  UserViewProtocols.swift
//  iOS10-HW22-Bessonov Ilia
//
//  Created by i0240 on 24.09.2023.
//

import Foundation

protocol UserView: AnyObject {
    func showPeople(_ people: [Person])
    func reloadTableView()
    func deletePerson(_ people: [Person])
}

protocol UserViewPresenter {
    func fetchPeople()
    func savePeople()
    func deletePeople(_ people: Person?)
}
