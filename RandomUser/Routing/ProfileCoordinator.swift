//
//  ProfileCoordinator.swift
//  RandomUser
//
//  Created by Efrén Pérez Bernabe on 22/03/21.
//

import UIKit

/// Profile routes
enum ProfileRoute {
    case profile
    case popVC
    case toastMessage(String)
    case sendEmail(email: String)
    case call(phone: URL?)
    case openLocation(latitude: Double, longitude: Double)
}

/// Profile Coordinator manage possible routes for Profile 
class ProfileCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        self.navigationController.delegate = self
    }
    
    /// Push new View Controller over the selected route
    /// - Parameter route: Browse route
    func trigger(route: ProfileRoute) {
        switch route {
        case .popVC:
            navigationController.popViewController(animated: true)
        case .profile:
            navigationController.initWithRootViewController(UserProfileViewController())
        case .toastMessage(let message):
            Helper.shared.showToast(message: message)
        case .sendEmail(let userEmail):
            navigationController.sendCustomEmail(recipients: [userEmail])
        case .call(let url):
            guard let url = url else { return }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        case .openLocation(let latitude, let longitude):
            MapKitManager.openLocationInMaps(latitude: latitude, longitude: longitude)
        }
    }
    
    /// Allow finish routes from one of its childs
    /// - Parameter child: Child  coordinator
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() where coordinator === child {
                childCoordinators.remove(at: index)
            break
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Read the view controller we’re moving from.
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        // Check whether our view controller array already contains that view controller.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

    }

}
