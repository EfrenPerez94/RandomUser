//
//  ProfileHeaderViewModel.swift
//  RandomUser
//
//  Created by Efrén Pérez Bernabe on 24/03/21.
//

import Foundation

private extension String {
    static let digits = "0123456789."
    static let tryAgainLater = "Try Again Later."
}

final class ProfileHeaderViewModel {
    
    // MARK: - Private properties
    private var coordinator: ProfileCoordinator
    private var phoneNumber: Int?
    private var latitude: Double?
    private var longitude: Double?
    private var email: String
    
    // MARK: - Public properties
    let descriptionText: Bindable<String> = Bindable("")
    let followState: Bindable<Bool> = Bindable(true)
    let profileURL: Bindable<String> = Bindable("")
    
    // MARK: - Init
    init(with coordinator: ProfileCoordinator, user: User) {
        self.coordinator = coordinator
        self.descriptionText.value = user.name.first.uppercased() + " - " + user.location.country.uppercased()
        self.profileURL.value = user.picture.large
        self.phoneNumber = Int(user.cell.filter(String.digits.contains))
        self.latitude = Double(user.location.coordinates.latitude.filter(String.digits.contains))
        self.longitude = Double(user.location.coordinates.longitude.filter(String.digits.contains))
        self.email = user.email
    }
    
    // MARK: - View Actions
    func didTapRefresh() {
        coordinator.trigger(route: .profile)
    }
    
    func didTapPhone() {
        guard let phoneNumber = phoneNumber else {
            coordinator.trigger(route: .toastMessage(.tryAgainLater))
            return
        }
        coordinator.trigger( route: .call(phone: URL(string: "tel://\(phoneNumber)")))
    }
    
    func didTapEmail() {
        coordinator.trigger(route: .sendEmail(email: email))
    }
    
    func didTapLocation() {
        guard let latitude = latitude,
              let longitude = longitude else {
            coordinator.trigger(route: .toastMessage(.tryAgainLater))
            return
        }
        coordinator.trigger(route: .openLocation(latitude: latitude, longitude: longitude))
    }
    
    func didTapFollow() {
        followState.value.toggle()
    }

}
