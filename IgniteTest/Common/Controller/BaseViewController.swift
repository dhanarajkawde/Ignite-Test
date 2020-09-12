//
//  BaseViewController.swift
//  IgniteTest
//
//  Created by Dhanraj Kawade on 11/09/20.
//  Copyright © 2020 Dhanraj Kawade. All rights reserved.
//

import UIKit
import SVGKit
import JGProgressHUD

/// Base class of UIViewController
class BaseViewController: UIViewController {

    // MARK:- Variable Declaration
    let hud = JGProgressHUD(style: .extraLight)
    
    // MARK:- View Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK:- Custom Methods
    
    /// Get Image from SVG
    /// - Parameter name: name
    /// - Returns: UIImage
    func getImageFromSVG(name : String) -> UIImage
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
    
    /// Show activity indicator
    /// - Parameter msg: message
    func showProgress(msg:String) {
        
        hud.textLabel.text = msg
        hud.show(in: self.view)
    }
    
    /// Stop activity indicator
    func stopProgress() {
        
        hud.dismiss()
    }
}
