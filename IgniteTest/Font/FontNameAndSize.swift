//
//  FontNameAndSize.swift
//  IgniteTest
//
//  Created by Dhanraj Kawade on 11/09/20.
//  Copyright © 2020 Dhanraj Kawade. All rights reserved.
//

import UIKit

/// Class to Provide Dynamic Font Sizes as per Device
class FontNameAndSize {
    
    static let shared = FontNameAndSize()
    
    //MARK: - PLIST constant for fontSize
    static let FontSizeXXXXXXXS = "FontSizeXXXXXXXS"
    static let FontSizeXXXXXXS = "FontSizeXXXXXXS"
    static let FontSizeXXXXXS = "FontSizeXXXXXS"
    static let FontSizeXXXXS = "FontSizeXXXXS"
    static let FontSizeXXXS = "FontSizeXXXS"
    static let FontSizeXXS = "FontSizeXXS"
    static let FontSizeXS = "FontSizeXS"
    static let FontSizeS = "FontSizeS"
    static let FontSizeM = "FontSizeM"
    static let FontSizeL = "FontSizeL"
    static let FontSizeXL = "FontSizeXL"
    static let FontSizeXXL = "FontSizeXXL"
    static let FontSizeXXXL = "FontSizeXXXL"
    static let FontSizeXXXXL = "FontSizeXXXXL"
    static let FontSizeXXXXXL = "FontSizeXXXXXL"
    static let FontSizeXXXXXXL = "FontSizeXXXXXXL"
    static let FontSizeXXXXXXXL = "FontSizeXXXXXXXL"
    
    static let Montserrat_Black = "Montserrat-Black"
    static let Montserrat_BlackItalic = "Montserrat-BlackItalic"
    static let Montserrat_Bold = "Montserrat-Bold"
    static let Montserrat_BoldItalic = "Montserrat-BoldItalic"
    static let Montserrat_ExtraBold = "Montserrat-ExtraBold"
    static let Montserrat_ExtraBoldItalic = "Montserrat-ExtraBoldItalic"
    static let Montserrat_ExtraLight = "Montserrat-ExtraLight"
    static let Montserrat_ExtraLightItalic = "Montserrat-ExtraLightItalic"
    static let Montserrat_Italic = "Montserrat-Italic"
    static let Montserrat_Light = "Montserrat-Light"
    static let Montserrat_LightItalic = "Montserrat-LightItalic"
    static let Montserrat_Medium = "Montserrat-Medium"
    static let Montserrat_MediumItalic = "Montserrat-MediumItalic"
    static let Montserrat_Regular = "Montserrat-Regular"
    static let Montserrat_SemiBold = "Montserrat-SemiBold"
    static let Montserrat_SemiBoldItalic = "Montserrat-SemiBoldItalic"
    static let Montserrat_Thin = "Montserrat-Thin"
    static let Montserrat_ThinItalic = "Montserrat-ThinItalic"
    
    /// get exact plist
    /// - Parameter plistName: name
    func readPlist(plistName : String) -> String {
        if let path = Bundle.main.path(forResource: plistName, ofType: "plist"){
            return path
        }
        return ""
    }
    
    /// This method returns font according to customer type.
    /// - Parameter size: size of font
    /// - Parameter fontName: font name
    func getSpecificFont(size:String, fontName:String) -> UIFont {
        
        let path = getPathAccToDevice()
        ////If your plist contain root as Dictionary
        if let dic = NSDictionary(contentsOfFile: path) as? [String: Any] {
            
            let fontName = fontName
            let fontSize =  dic[size]! as! CGFloat
            
            return  UIFont(name: fontName, size: fontSize)!
        }
        return UIFont()
    }
    
    /// Function to get the plist of specific device
    ///
    /// - Returns: path in string format
    func getPathAccToDevice()->String
    {
        var path = readPlist(plistName: "iPhone1X")
        
        switch UIDevice().screenType {
        case .iPhone5:
            path = readPlist(plistName: "iPhone1X")
            
        case .iPhone6:
            path = readPlist(plistName: "iPhone2X")
            
        case .iPhone6Plus:
            path = readPlist(plistName: "iPhone3X")
            
        case .unknown:
            path = readPlist(plistName: "iPhone2X")
            
        default: break
        }
        
        return path
    }
}


