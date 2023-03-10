//
//  Article.swift
//  NewsAPI
//
//  Created by Wilbert Devin Wijaya on 25/02/23.
//

import Foundation

struct Article : Codable {

    let author : String?
    let content : String?
    let descriptionField : String?
    let publishedAt : String?
    let title : String?
    let url : String?
    let urlToImage : String?


    enum CodingKeys: String, CodingKey {
        case author = "author"
        case content = "content"
        case descriptionField = "description"
        case publishedAt = "publishedAt"
        case title = "title"
        case url = "url"
        case urlToImage = "urlToImage"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        author = try values.decodeIfPresent(String.self, forKey: .author)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        urlToImage = try values.decodeIfPresent(String.self, forKey: .urlToImage)
    }


}
