//
//  UIView.swift
//  RandomUser
//
//  Created by Efrén Pérez Bernabe on 24/03/21.
//

import UIKit

extension UIView {
    
    /// Allow fix UIView inside a container
    /// - Parameters:
    ///   - container: Parent container.
    ///   - topConstant: Top constraint constant
    ///   - leadingConstant: Leading constraint constant
    ///   - bottomConstant: Bottom constraint constant
    ///   - trailingConstant: Trailing constraint constant
    func fixInView(_ container: UIView,
                   topConstant: CGFloat = 0.0,
                   leadingConstant: CGFloat = 0.0,
                   bottomConstant: CGFloat = 0.0,
                   trailingConstant: CGFloat = 0.0) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = container.frame
        container.addSubview(self)
        self.topAnchor.constraint(equalTo: container.topAnchor, constant: topConstant).isActive = true
        self.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: leadingConstant).isActive = true
        self.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: bottomConstant).isActive = true
        self.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: trailingConstant).isActive = true
    }
}
