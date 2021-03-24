//
//  UIViewController+MFMailComposer.swift
//  RandomUser
//
//  Created by Efrén Pérez Bernabe on 24/03/21.
//

import Foundation
import MessageUI

@objc extension UIViewController: MFMailComposeViewControllerDelegate {
    
    /// Create a custom email and present a MFMailComposeViewController.
    ///
    /// - Parameters:
    ///   - recipients: Array of email's address.
    func sendCustomEmail(recipients: [String]?) {
        
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(recipients)
        self.presentMailComposeViewController(mailComposeVC)
    }
    
    /// Perform the presentation of the MFMailComposeViewController.
    ///
    /// - Parameter mailComposeViewController: View controller to be presented.
    private func presentMailComposeViewController(_ mailComposeVC: MFMailComposeViewController) {
        
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeVC, animated: true, completion: nil)
        } else {
            Helper.shared.showToast(message: "Unable To Send Email")
        }
    }
    
    /// Allow dismiss MFMailComposeViewController after an action is performed.
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
