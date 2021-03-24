//
//  UINavigationController.swift
//  RandomUser
//
//  Created by Efrén Pérez Bernabe on 22/03/21.
//

import Foundation
import UIKit

extension UINavigationController {

    /// It removes all view controllers from navigation controller then set the new root view controller .
    /// - Parameter controller: new root view controller to set
    func initWithRootViewController(_ controller: UIViewController) {
        self.viewControllers.removeAll()
        self.pushViewController(controller, animated: false)
        self.popToRootViewController(animated: false)
    }
}
