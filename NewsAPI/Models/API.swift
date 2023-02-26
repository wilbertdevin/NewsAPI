//
//  API.swift
//  NewsAPI
//
//  Created by Wilbert Devin Wijaya on 25/02/23.
//

import Foundation

struct Secret {
    static let secretKey: String = "c8f93ef8504e4c42b5bacee31dc21aca"//"GET YOUR OWN API KEY FROM NEWSAPI.ORG"
    
    static let sourceID: String = UserDefaults.standard.value(forKey: "source") as! String
    
    static var currentPage:Int = 1
    static let pageSize:Int = 20
}
