//
//  APIManager.swift
//  Rene
//
//  Created by Dhanraj Kawade on 11/09/20.
//  Copyright © 2020 Dhanraj Kawade. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

//HTTP Methods
enum HttpMethod : String {
    case  GET
    case  POST
    case  DELETE
    case  PUT
}

typealias Parameters = [String: String]

/// Class get common instance of API
class APIManager: NSObject {
    
    //TODO: remove app transport security arbitary constant from info.plist file once we get API's
    var request : URLRequest?
    var session : URLSession?
    
    var baseUrl = "http://skunkworks.ignitesol.com:8000/"
    
    static let sharedInstance = APIManager()
    
    /// Json API Call
    /// - Parameters:
    ///   - url: url
    ///   - params: parameters
    ///   - method: HTTP Method Type
    ///   - success: success
    ///   - failure: failure
    func makeJsonAPICall(url: String,params: Dictionary<String, Any>?, method: HttpMethod, success:@escaping ( Data?, HTTPURLResponse?, Error? ) -> Void, failure: @escaping ( Data? ,HTTPURLResponse?, NSError? )-> Void) {
        
        request = URLRequest(url: URL(string: "\(baseUrl)\(url)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")!)
        
        if let params = params { // if parameter not nil
                        
            let  jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            
            request?.httpBody = jsonData
        }
        request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request?.setValue("application/json", forHTTPHeaderField: "Accept")
        request?.httpMethod = method.rawValue
        
        let configuration = URLSessionConfiguration.default
        
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        
        session = URLSession(configuration: configuration)
        
        session?.dataTask(with: request! as URLRequest) { (data, response, error) -> Void in
            
            if let data = data {
                
                success(data, response as? HTTPURLResponse, error as NSError?)

            }else {
                
                failure(data , response as? HTTPURLResponse, error as NSError?)
            }
        }.resume()
    }
}
