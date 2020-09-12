//
//  BookList.swift
//  IgniteTest
//
//  Created by Dhanraj Kawade on 11/09/20.
//  Copyright © 2020 Dhanraj Kawade. All rights reserved.
//

import Foundation

/// Struct for Book List
struct BookList : Codable {
    
    var count:Int?
    var next:String?
    var previous:String?
    var results:[SingleBook]?
}

/// Struct for Book
struct SingleBook : Codable {
    
    var id:Int?
    var authors:[Author]?
    var bookshelves:[String]?
    var download_count:Int?
    
    //#TODO:- Need to Parse but has no proper understanding
    //    var formats": {
    //    "text/plain": "http://www.gutenberg.org/ebooks/844.txt.utf-8",
    //    "text/html": "http://www.gutenberg.org/files/844/844-h.zip",
    //    "application/x-mobipocket-ebook": "http://www.gutenberg.org/ebooks/844.kindle.noimages",
    //    "text/plain; charset=us-ascii": "http://www.gutenberg.org/files/844/844.zip",
    //    "application/rdf+xml": "http://www.gutenberg.org/ebooks/844.rdf",
    //    "application/epub+zip": "http://www.gutenberg.org/ebooks/844.epub.images"
    //    },
    
    var languages:[String]?
    var media_type:String?
    var subjects:[String]?
    var title:String?
}

/// Struct for Author
struct Author : Codable {
    
    var birth_year:Int?
    var death_year:Int?
    var name:String?
}
