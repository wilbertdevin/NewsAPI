//
//  RootClass.swift
//  NewsAPI
//
//  Created by Wilbert Devin Wijaya on 25/02/23.
//

import Foundation

struct RootClass : Codable {

    let sources : [Source]?
    let status : String?


    enum CodingKeys: String, CodingKey {
        case sources = "sources"
        case status = "status"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sources = try values.decodeIfPresent([Source].self, forKey: .sources)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }


}
