//
//  CategoryListTableViewCell.swift
//  IgniteTest
//
//  Created by Dhanraj Kawade on 11/09/20.
//  Copyright © 2020 Dhanraj Kawade. All rights reserved.
//

import UIKit

/// Class to show Category
class CategoryListTableViewCell: UITableViewCell {

    // MARK:- IB Outlet
    @IBOutlet weak var viwBack: UIView!
    @IBOutlet weak var imgViwHeader: UIImageView!
    @IBOutlet weak var imgViwArrow: UIImageView!
    @IBOutlet weak var lblHeader: UILabel!
    
    // MARK:- View Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.lblHeader.setContentForLabel(title: "", fontSize: FontNameAndSize.FontSizeXL, FontName: FontNameAndSize.Montserrat_SemiBold, textColor: UIColor(hexString: GlobalColors.darkGrayColor))
        self.imgViwArrow.image = self.imgViwArrow.getUIImageFromSVG(name: "next")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.viwBack.layer.cornerRadius = 4.0
        self.viwBack.addShadow(offset: CGSize(width: 1.0, height: 1.0), color: UIColor(hexString: GlobalColors.boxShadow), radius: 4, opacity: 0.3)
    }
    
    // MARK:- Custom Methods
    
    /// Set Data for Cell
    /// - Parameter name: String
    func setData(name:String) {
        
        self.lblHeader.text = name.uppercased()
        self.imgViwHeader.image = self.imgViwHeader.getUIImageFromSVG(name: name)
    }
}
