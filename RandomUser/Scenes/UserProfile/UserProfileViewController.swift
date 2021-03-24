//
//  UserProfileViewController.swift
//  RandomUser
//
//  Created by Efrén Pérez Bernabe on 24/03/21.
//

import UIKit

class UserProfileViewController: UIViewController {
        
    // MARK: - Private properties
    @IBOutlet private weak var profileHeaderView: ProfileHeaderView!
    
    // MARK: - Public properties
    var coordinator: ProfileCoordinator?

    // MARK: - Life View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        coordinatorSetup()
        loadData()
    }
            
    // MARK: - View Setup
    private func loadData() {
        Helper.shared.showActivityIndicator()
        ServiceRepository.executeFromServer(RequestManager.fetchUser()) { [weak self] result in
            guard let weakSelf = self else {
                fatalError("Self contains a nil value")
            }
            Helper.shared.hideActivityIndicator()
            switch result {
            case .success(let user):
                guard let coordinator = weakSelf.coordinator else { return }
                weakSelf.profileHeaderView.viewModel = ProfileHeaderViewModel(with: coordinator, user: user)
            case .failure(let error):
                weakSelf.coordinator?.trigger(route: .toastMessage(error.localizedDescription))
            }
        }
    }
        
    private func coordinatorSetup() {
        guard let navController = navigationController else {
            fatalError("Application not embedded on navigationController")
        }
        coordinator = ProfileCoordinator(navigationController: navController)
    }
}
