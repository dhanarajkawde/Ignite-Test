//
//  BookListCollectionViewCell.swift
//  IgniteTest
//
//  Created by Dhanraj Kawade on 11/09/20.
//  Copyright © 2020 Dhanraj Kawade. All rights reserved.
//

import UIKit

/// Class show Book info
class BookListCollectionViewCell: UICollectionViewCell {

    // MARK:- IB Outlet
    @IBOutlet weak var viwBack: UIView!
    @IBOutlet weak var imgViwBook: UIImageView!
    @IBOutlet weak var lblBookName: UILabel!
    @IBOutlet weak var lblAuthorName: UILabel!
    
    // MARK:- View Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.lblBookName.setContentForLabel(title: "THE OLD MAN AND THE SEA", fontSize: FontNameAndSize.FontSizeXXS, FontName: FontNameAndSize.Montserrat_SemiBold, textColor: UIColor(hexString: GlobalColors.darkGrayColor))
        self.lblAuthorName.setContentForLabel(title: "Charles Dickens", fontSize: FontNameAndSize.FontSizeXXXS, FontName: FontNameAndSize.Montserrat_SemiBold, textColor: UIColor(hexString: GlobalColors.grayColor))
        
        self.viwBack.backgroundColor = UIColor(hexString: GlobalColors.backgroundColor)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imgViwBook.layer.cornerRadius = 8.0
        self.imgViwBook.addShadow(offset: CGSize(width: 1.0, height: 1.0), color: UIColor(hexString: GlobalColors.boxShadow), radius: 5, opacity: 0.3)
    }

    // MARK:- Custom Methods
    
    /// Set data for Cell
    /// - Parameter data: SingleBook
    func setData(data:SingleBook?) {
        
        self.lblBookName.text = data?.title ?? ""
        self.lblAuthorName.text = (data?.authors?.count ?? 0) > 0 ? (data?.authors?[0].name) : ""
    }
}
