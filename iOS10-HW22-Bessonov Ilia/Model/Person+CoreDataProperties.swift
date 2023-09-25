//
//  Person+CoreDataProperties.swift
//  iOS10-HW22-Bessonov Ilia
//
//  Created by i0240 on 17.09.2023.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var age: String?
    @NSManaged public var gender: String?
    @NSManaged public var name: String?

}

extension Person : Identifiable {

}
