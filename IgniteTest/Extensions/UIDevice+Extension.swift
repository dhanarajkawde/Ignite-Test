//
//  UIDevice+Extension.swift
//  Rene
//
//  Created by Dhanraj Kawade on 18/07/20.
//  Copyright © 2020 Resonance. All rights reserved.
//

import UIKit

// Common extension of UIDevice
extension UIDevice {
    
    enum UIUserInterfaceIdiom : Int {
        case unspecified
        case phone
        case pad
    }
    
    var iPhone: Bool {
        return UIDevice().userInterfaceIdiom == .phone
    }
    
    enum ScreenType: String {
        case iPhone4
        case iPhone5
        case iPhone6
        case iPhone6Plus
        case unknown
    }
    
    var screenType: ScreenType {
        guard iPhone else { return .unknown }
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhone4
        case 1136:
            return .iPhone5
        case 1334, 2436:
            return .iPhone6
        case 1792, 1920, 2208, 2688:
            return .iPhone6Plus
        default:
            return .unknown
        }
    }
}
