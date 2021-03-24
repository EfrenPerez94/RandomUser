//
//  CustomButton.swift
//  RandomUser
//
//  Created by Efrén Pérez Bernabe on 24/03/21.
//

import UIKit

/// Custom IBInspectable Button, allow set kern and borderColor
 class CustomButton: UIButton {

     @IBInspectable var borderColor: UIColor? {
         didSet {
             layer.borderColor = borderColor?.cgColor
         }
     }

     @IBInspectable open var characterSpacing: CGFloat = 0 {
         didSet {
             let attributedString = NSMutableAttributedString(string: self.titleLabel?.text ?? "")
             attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))
             self.titleLabel?.attributedText = attributedString
         }
     }
 }
