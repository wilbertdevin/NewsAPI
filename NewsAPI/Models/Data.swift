//
//  Data.swift
//  NewsAPI
//
//  Created by Wilbert Devin Wijaya on 25/02/23.
//

import Foundation

struct ArticlesData : Codable {

    let articles : [Article]?
    let status : String?
    let totalResults : Int?


    enum CodingKeys: String, CodingKey {
        case articles = "articles"
        case status = "status"
        case totalResults = "totalResults"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        articles = try values.decodeIfPresent([Article].self, forKey: .articles)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)
    }


}
