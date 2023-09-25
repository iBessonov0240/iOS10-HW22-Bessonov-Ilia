//
//  UsersPresenter.swift
//  iOS10-HW22-Bessonov Ilia
//
//  Created by i0240 on 19.09.2023.
//

import UIKit

class UserPresenter {

    weak var userView: UserView?
    private var person: [Person]?
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

    init(userView: UserView? = nil, person: [Person]? =  nil) {
        self.userView = userView
        self.person = person
    }
}

extension UserPresenter: UserViewPresenter {

    func fetchPeople() {
        // Fetch the data from Core Data to display in the tableView
        do {
            let request = Person.fetchRequest()

            // Set the filtering and sorting on the request
            let sort = NSSortDescriptor(key: "name", ascending: true)
            request.sortDescriptors = [sort]

            guard let person = try context?.fetch(request) else { return }

            DispatchQueue.main.async {
                self.person = person
                self.userView?.showPeople(person)
            }
        } catch {
            print("Can't fetch data from Core Data")
        }
    }

    func savePeople() {
            // Save the data
            do {
                try self.context?.save()
            } catch {
                print(error)
            }
            // Re-fetch the data
            fetchPeople()
            userView?.reloadTableView()
    }

    func deletePeople(_ people: Person?) {
        if let context = self.context, let people = people {
            context.delete(people)
        }
    }
}
