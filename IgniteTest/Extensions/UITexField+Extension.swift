//
//  UITexField+Extension.swift
//  Rene
//
//  Created by Dhanraj Kawade on 18/07/20.
//  Copyright © 2020 Resonance. All rights reserved.
//

import UIKit
// Common extension of UIColor
extension UITextField {
    
    /// Set content for TextField
    /// - Parameters:
    ///   - fontSize: font size
    ///   - FontName: font name
    ///   - placeHolder: placeholde
    ///   - textColor: text color
    ///   - placeholderColor: placeholder color
    func setContentForTextField(fontSize:String, FontName:String, placeHolder:String, textColor:UIColor, placeholderColor:UIColor) {
        
        self.placeholder = placeHolder
        self.font = FontNameAndSize.shared.getSpecificFont(size: fontSize, fontName: FontName)
        self.textColor = textColor
        self.attributedPlaceholder = NSAttributedString(string: placeHolder,
        attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
    }
}
