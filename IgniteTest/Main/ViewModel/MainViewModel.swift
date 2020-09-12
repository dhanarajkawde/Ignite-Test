//
//  MainViewModel.swift
//  IgniteTest
//
//  Created by Dhanraj Kawade on 12/09/20.
//  Copyright © 2020 Dhanraj Kawade. All rights reserved.
//

import Foundation

/// Class to get common instance Main Model
class MainViewModel: NSObject {
    
    static let sharedInstance = MainViewModel()
    
    /// Get Book List based on category
    /// - Parameters:
    ///   - category: category
    ///   - isFirst: is first call
    ///   - completion: completion description
    func getBookListAPI(category:String, isFirst:Bool, completion: @escaping (BookList?, HTTPURLResponse?) -> Void) {
        
        var extensionUrl = "books?topic=\(category)"
        
        if !isFirst { // not first call
            extensionUrl = category
        }
        
        APIManager.sharedInstance.makeJsonAPICall(url: extensionUrl, params: nil, method: .GET, success: { (data, response, error) in
            
            do
            {
                if let jsonData = data
                {
                    let bookList = try JSONDecoder().decode(BookList.self, from: jsonData)
                    completion(bookList, response)
                }
            }
            catch
            {
                completion(nil, response)
            }
        }, failure: { (data, response, error) in
            
            completion(nil, response)
        })
    }
    
    /// Get Book List based on Search
    /// - Parameters:
    ///   - category: category
    ///   - searchString: searched string
    ///   - isFirst: is First call
    ///   - completion: completion description
    func getSearchedBookListAPI(category:String, searchString:String, isFirst:Bool, completion: @escaping (BookList?, HTTPURLResponse?) -> Void) {
        
        var extensionUrl = "books?topic=\(category)&search=\(searchString)"
        
        if !isFirst { // not first call
            extensionUrl = category
        }
        
        APIManager.sharedInstance.makeJsonAPICall(url: extensionUrl, params: nil, method: .GET, success: { (data, response, error) in
            
            do
            {
                if let jsonData = data
                {
                    let bookList = try JSONDecoder().decode(BookList.self, from: jsonData)
                    completion(bookList, response)
                }
            }
            catch
            {
                completion(nil, response)
            }
        }, failure: { (data, response, error) in
            
            completion(nil, response)
        })
    }
}
