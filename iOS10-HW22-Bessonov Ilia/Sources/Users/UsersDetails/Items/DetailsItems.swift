//
//  DetailsItems.swift
//  iOS10-HW22-Bessonov Ilia
//
//  Created by i0240 on 16.09.2023.
//

import UIKit

enum CellType {
    case name
    case date
    case gender
}

struct UserDetailsItems {
    var icon: UIImage?
    var type: CellType
}

extension UserDetailsItems {
    static var items: [UserDetailsItems] = [
        UserDetailsItems(icon: UIImage(systemName: "person"), type: .name),
        UserDetailsItems(icon: UIImage(systemName: "calendar"), type: .date),
        UserDetailsItems(icon: UIImage(systemName: "person.2.circle"), type: .gender)
    ]
}
