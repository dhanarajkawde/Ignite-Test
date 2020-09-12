//
//  BookListViewController.swift
//  IgniteTest
//
//  Created by Dhanraj Kawade on 11/09/20.
//  Copyright © 2020 Dhanraj Kawade. All rights reserved.
//

import UIKit

class BookListViewController: BaseViewController {

    // MARK:- IB Outlet
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var viwSearch: UIView!
    @IBOutlet weak var collectionViwBook: UICollectionView!
    @IBOutlet weak var imgViwSearch: UIImageView!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    
    // MARK:- Variable Declaration
    var selectedCategory:String?
    var searchText:String?
    var arrBooks:[SingleBook]?
    var totalCount:Int?
    var isFirst = true
    var nextUrl = ""
    var timer: Timer? = nil
    let refreshControlView = UIRefreshControl()
    
    // MARK:- View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpUI()
        
        self.collectionViwBook.register(UINib(nibName: CellIdentifier.BookListCollectionViewCell, bundle: .main), forCellWithReuseIdentifier: CellIdentifier.BookListCollectionViewCell)
        
        DispatchQueue.main.async {
         
            self.getBookList()
        }
    }
    
    // MARK:- Custom Methods
    
    func setUpUI() {
        
        self.btnBack.setImage(self.getImageFromSVG(name: "back"), for: .normal)
        self.btnBack.tintColor = UIColor(hexString: GlobalColors.purpleThemeColor)
        
        self.btnSearch.setImage(self.getImageFromSVG(name: "cancel"), for: .normal)
        self.btnSearch.tintColor = UIColor(hexString: GlobalColors.grayColor)
        self.btnSearch.isHidden = true
        
        self.lblHeader.setContentForLabel(title: self.selectedCategory?.capitalized ?? "", fontSize: FontNameAndSize.FontSizeXXXXXL, FontName: FontNameAndSize.Montserrat_SemiBold, textColor: UIColor(hexString: GlobalColors.purpleThemeColor))
        self.txtSearch.setContentForTextField(fontSize: FontNameAndSize.FontSizeXL, FontName: FontNameAndSize.Montserrat_SemiBold, placeHolder: "Search", textColor: UIColor(hexString: GlobalColors.darkGrayColor), placeholderColor: UIColor(hexString: GlobalColors.grayColor))
        
        self.viwSearch.backgroundColor = UIColor(hexString: GlobalColors.backgroundColor)
        self.viwSearch.addCornerRadius(radius: 4.0)
        
        self.collectionViwBook.backgroundColor = UIColor(hexString: GlobalColors.backgroundColor)
        
        self.imgViwSearch.image = self.imgViwSearch.getUIImageFromSVG(name: "search")
        
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (self.view.frame.size.width / 3) - 15, height: 235)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 0.0
        self.collectionViwBook.collectionViewLayout = flowLayout
        
        self.collectionViwBook.alwaysBounceVertical = true
         
        self.refreshControlView.tintColor = UIColor(hexString: GlobalColors.lightGrayColor)
        self.collectionViwBook.refreshControl = refreshControlView
        
        self.viwSearch.layer.borderWidth = 0.0
    }
    
    /// Btn Back clicked
    /// - Parameter sender: sender description
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    /// btn search clicked
    /// - Parameter sender: sender description
    @IBAction func btnSearchClicked(_ sender: UIButton) {
        
        self.txtSearch.text = ""
        
        DispatchQueue.main.async {
         
            self.arrBooks?.removeAll()
            self.isFirst = true
            self.getBookList()
            self.btnSearch.isHidden = true
        }
    }
    
    /// Get Book list on category
    func getBookList() {
        
        DispatchQueue.main.async {
            if self.isFirst { // is first call
                self.showProgress(msg: "")
            }
        }
        
        MainViewModel.sharedInstance.getBookListAPI(category: self.selectedCategory ?? "", isFirst: self.isFirst) { (books, response) in
            
            DispatchQueue.main.async {
                if self.isFirst { // is first call
                    self.stopProgress()
                }
            }
            
            if (books?.results?.count ?? 0) > 0 { // if result of books not nil
                
                if self.arrBooks == nil { // if array nil
                    
                    self.arrBooks = books?.results
                }
                else {
                    self.arrBooks?.append(contentsOf: (books?.results)!)
                }
                
                self.nextUrl = (books?.next ?? "").replacingOccurrences(of: APIManager.sharedInstance.baseUrl, with: "")
                self.totalCount = books?.count
            }
            else {
                self.nextUrl = ""
            }
            
            DispatchQueue.main.async {
                
                self.collectionViwBook.reloadData()
            }
        }
    }
    
    /// Get Book list on Searched string
    func getSearchedBookList() {
        
        MainViewModel.sharedInstance.getSearchedBookListAPI(category: self.selectedCategory ?? "", searchString: self.searchText ?? "", isFirst: self.isFirst) { (books, response) in
            
            if (books?.results?.count ?? 0) > 0 { // if result of books not nil
                
                if self.arrBooks == nil { // if array nil
                    
                    self.arrBooks = books?.results
                }
                else {
                    self.arrBooks?.append(contentsOf: (books?.results)!)
                }
                
                self.nextUrl = (books?.next ?? "").replacingOccurrences(of: APIManager.sharedInstance.baseUrl, with: "")
                self.totalCount = books?.count
            }
            else {
                self.nextUrl = ""
                
                if self.isFirst {
                    self.arrBooks?.removeAll()
                }
            }
            
            DispatchQueue.main.async {
                
                self.collectionViwBook.reloadData()
            }
        }
    }
}

// MARK:- UICollectionViewDelegate, UICollectionViewDataSource
extension BookListViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.arrBooks?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let bookListCollectionViewCell:BookListCollectionViewCell = self.collectionViwBook.dequeueReusableCell(withReuseIdentifier: CellIdentifier.BookListCollectionViewCell, for: indexPath) as! BookListCollectionViewCell
        
        bookListCollectionViewCell.backgroundColor = UIColor(hexString: GlobalColors.backgroundColor)
        bookListCollectionViewCell.setData(data: self.arrBooks?[indexPath.row])
        
        return bookListCollectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if self.txtSearch.text == "" {
            
            if indexPath.row == (self.arrBooks?.count ?? 0) - 6 && self.nextUrl != "" { // get API call before last index get comes
                
                self.isFirst = false
                self.selectedCategory = self.nextUrl
                self.getBookList()
            }
        }
        else {
         
            if indexPath.row == (self.arrBooks?.count ?? 0) - 6 && self.nextUrl != "" { // get API call before last index get comes
                
                self.isFirst = false
                self.selectedCategory = self.nextUrl
                self.getSearchedBookList()
            }
        }
    }
}

// MARK:- UITextFieldDelegate
extension BookListViewController : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.viwSearch.layer.borderWidth = 1.0
        self.viwSearch.layer.borderColor = UIColor(hexString: GlobalColors.purpleThemeColor).cgColor
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.viwSearch.layer.borderWidth = 0.0
        
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        
        self.searchText = newString as String
        self.isFirst = true
        self.arrBooks?.removeAll()
        
        if newString.length > 0 {
            
            self.btnSearch.isHidden = false
            
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.getHints), userInfo: nil, repeats: false)
        }
        else {
            self.btnSearch.isHidden = true
        }
        
        return  true
    }
    
    /// Call API after user paused for 0.5 after typing
    /// - Parameter timer: timer description
    @objc func getHints(timer: Timer) {

        DispatchQueue.main.async {
         
            self.getSearchedBookList()
        }
    }
}
