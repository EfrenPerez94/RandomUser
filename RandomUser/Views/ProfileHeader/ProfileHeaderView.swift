//
//  ProfileHeaderView.swift
//  RandomUser
//
//  Created by Efrén Pérez Bernabe on 23/03/21.
//

import UIKit

/// View Class for Profile Header
final class ProfileHeaderView: UIView {
    
    // MARK: - Private properties
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var profilePhotoImageView: UIImageView!
    @IBOutlet private weak var followButton: UIButton!
    
    // MARK: - Public properties
    static let identifier: String = String(describing: ProfileHeaderView.self)
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }

    var viewModel: ProfileHeaderViewModel? {
        didSet {
            fillUI()
        }
    }
        
    // MARK: - Life View Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
            
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
            
    private func commonInit() {
        Bundle.main.loadNibNamed(ProfileHeaderView.identifier, owner: self, options: nil)
        contentView.fixInView(self)
        profilePhotoSetupLayer()
    }
    
    // MARK: - UI setup
    private func fillUI() {
        guard let viewModel = viewModel else { return }
        viewModel.descriptionText.bindAndFire { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.descriptionLabel.text = $0
        }
        viewModel.profileURL.bindAndFire { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.profilePhotoImageView.imageFromURL($0)
        }
        viewModel.followState.bindAndFire { [weak self] in
            guard let weakSelf = self else { return }
            let title = $0 ? "FOLLOW" : "UNFOLLOW"
            weakSelf.followButton.setTitle(title, for: .normal)
        }
    }
    
    private func profilePhotoSetupLayer() {
        self.profilePhotoImageView.layer.borderWidth = 4.0
        self.profilePhotoImageView.layer.borderColor = UIColor.white.cgColor
    }

    // MARK: - Actions

    @IBAction private func refreshTouchUpInside() {
        viewModel?.didTapRefresh()
    }
    
    @IBAction private func phoneTouchUpInside() {
        viewModel?.didTapPhone()
    }
    
    @IBAction private func emailTouchUpInside() {
        viewModel?.didTapEmail()
    }
    
    @IBAction private func locationTouchUpInside() {
        viewModel?.didTapLocation()
    }
    
    @IBAction private func followTouchUpInside() {
        viewModel?.didTapFollow()
    }
    
}
