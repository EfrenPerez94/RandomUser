//
//  Helper.swift
//  RandomUser
//
//  Created by Efrén Pérez Bernabe on 22/03/21.
//

import Foundation
import UIKit

class Helper {
    
    private var loadingView = UIView()
    private var activityIndicator = UIActivityIndicatorView()
    
    static var shared = Helper()
    static let window = UIApplication.shared.windows.first { $0.isKeyWindow }
    
    /// Display a loading activity indicator over a current view
    /// - Parameter view: View where the indicator will be displayed
    func showActivityIndicator(over view: UIView? = window,
                               frame: CGRect = CGRect(x: 0, y: 0, width: 100, height: 100),
                               backgroundColor: UIColor = .clear,
                               style: UIActivityIndicatorView.Style = .large) {
        
        guard let view = view else { return }
        loadingView.bounds = frame
        loadingView.center = view.center
        loadingView.backgroundColor = backgroundColor
    
        activityIndicator.frame = loadingView.frame
        activityIndicator.style = style
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)

        loadingView.addSubview(activityIndicator)
        view.addSubview(loadingView)
        activityIndicator.startAnimating()
    }
    
    /// Hide the current activity indicator
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        loadingView.removeFromSuperview()
    }
    
    /// Create and shows a custom toast message.
    func showToast(message: String) {
        guard let safeWindow = Helper.window else { return }
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.textAlignment = .center
        toastLabel.textColor = UIColor.white
        toastLabel.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
            
        let textSize = toastLabel.intrinsicContentSize
        let labelWidth = min(textSize.width, safeWindow.frame.width - (20 * 2)) + 20
            
        toastLabel.frame = CGRect(x: ((safeWindow.frame.size.width - labelWidth) / 2), y: safeWindow.frame.size.height - 70, width: labelWidth, height: 30)
        toastLabel.layer.cornerRadius = 30 / 2
        toastLabel.layer.masksToBounds = true
            
        safeWindow.addSubview(toastLabel)
            
        UIView.animate(withDuration: 3.0, animations: {
            toastLabel.alpha = 0
        }, completion: { _ in
            toastLabel.removeFromSuperview()
        })
    }
    
}
