//
//  CategoryListViewController.swift
//  IgniteTest
//
//  Created by Dhanraj Kawade on 11/09/20.
//  Copyright © 2020 Dhanraj Kawade. All rights reserved.
//

import UIKit

class CategoryListViewController: BaseViewController {
    
    // MARK:- IB Outlet
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblDecription: UILabel!
    @IBOutlet weak var tblCategoryList: UITableView!
    @IBOutlet weak var imgViwBack: UIImageView!
    
    // MARK:- Variable Declaration
    let arrCategories = [Localizable.FICTION, Localizable.DRAMA, Localizable.HUMOR, Localizable.POLITICS, Localizable.PHILOSOPHY, Localizable.HISTORY, Localizable.ADVENTURE]
    
    // MARK:- View Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpUI()
        
        self.tblCategoryList.register(UINib(nibName: CellIdentifier.CategoryListTableViewCell, bundle: .main), forCellReuseIdentifier: CellIdentifier.CategoryListTableViewCell)
    }
    
    // MARK:- Custom Methods
    
    /// Set Up UI
    func setUpUI() {
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.view.backgroundColor = UIColor(hexString: GlobalColors.backgroundColor)
        
        self.lblHeader.setContentForLabel(title: Localizable.GutenbergProject, fontSize: FontNameAndSize.FontSizeXXXXXXXL, FontName: FontNameAndSize.Montserrat_SemiBold, textColor: UIColor(hexString: GlobalColors.purpleThemeColor))
        self.lblDecription.setContentForLabel(title: Localizable.GutenbergProjectDesc, fontSize: FontNameAndSize.FontSizeM, FontName: FontNameAndSize.Montserrat_SemiBold, textColor: UIColor(hexString: GlobalColors.darkGrayColor))
        
        self.imgViwBack.image = self.getImageFromSVG(name: "pattern")
        self.imgViwBack.contentMode = .scaleAspectFill
        
        self.tblCategoryList.backgroundColor = UIColor(hexString: GlobalColors.backgroundColor)
    }
}

// MARK:- UITableViewDelegate, UITableViewDataSource
extension CategoryListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let categoryListTableViewCell:CategoryListTableViewCell = self.tblCategoryList.dequeueReusableCell(withIdentifier: CellIdentifier.CategoryListTableViewCell, for: indexPath) as! CategoryListTableViewCell
        
        categoryListTableViewCell.setData(name: self.arrCategories[indexPath.row])
        categoryListTableViewCell.backgroundColor = UIColor(hexString: GlobalColors.backgroundColor)
        
        return categoryListTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let bookListViewController:BookListViewController = storyboard.instantiateViewController(withIdentifier: "BookListViewController") as! BookListViewController
        
        bookListViewController.selectedCategory = self.arrCategories[indexPath.row]
        
        self.navigationController?.pushViewController(bookListViewController, animated: true)
    }
}
