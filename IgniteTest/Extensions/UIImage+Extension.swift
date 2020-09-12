//
//  UIImage+Extension.swift
//  IgniteTest
//
//  Created by Dhanraj Kawade on 11/09/20.
//  Copyright © 2020 Dhanraj Kawade. All rights reserved.
//

import UIKit
import SVGKit

// Common extension of UIImageView
extension UIImageView {
    
    /// Get Image from SVG
    /// - Parameter name: name
    /// - Returns: UIImage
    func getUIImageFromSVG(name : String) -> UIImage
    {
        let path = Bundle.main.path(forResource: name, ofType: "svg")
        do{
            let svgData = try String(contentsOfFile: path!)
            let d = svgData.data(using: .utf8)
            let receivedIcon: SVGKImage = SVGKImage(data: d)
            let img = receivedIcon.uiImage
            return img!
        }
        catch let error{
            print("Error",error.localizedDescription)
        }
        return UIImage()
    }
}
