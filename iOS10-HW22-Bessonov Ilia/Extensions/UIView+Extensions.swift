//
//  UIView+Extensions.swift
//  iOS10-HW22-Bessonov Ilia
//
//  Created by i0240 on 12.09.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}
