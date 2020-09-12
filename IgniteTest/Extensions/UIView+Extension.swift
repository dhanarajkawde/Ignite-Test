//
//  UIView+Extension.swift
//  Rene
//
//  Created by Dhanraj Kawade on 18/07/20.
//  Copyright © 2020 Resonance. All rights reserved.
//

import UIKit

/// Shadow Tyoe
enum DropShadowType {
    case rect, circle, dynamic
}

/// Corner of View
enum ViewSide {
    case Left, Right, Top, Bottom
}

// Common extension of UIView
extension UIView {
    
    /// Add shadow
    /// - Parameters:
    ///   - offset: offset
    ///   - color: color
    ///   - radius: corner radius
    ///   - opacity: opacity
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
    
    /// Set corner radius to View
    /// - Parameter radius: radius
    func addCornerRadius(radius:CGFloat) {
        
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
