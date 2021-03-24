//
//  CoordinatorProtocol.swift
//  RandomUser
//
//  Created by Efrén Pérez Bernabe on 22/03/21.
//

import UIKit

/// All coordinator classes must satisfy Coordinator protocol in order to control its childs and root navigationController
protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
}
