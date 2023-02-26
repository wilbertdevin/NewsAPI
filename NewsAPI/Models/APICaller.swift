//
//  APICaller.swift
//  NewsAPI
//
//  Created by Wilbert Devin Wijaya on 24/02/23.
//

import Foundation

final class APICaller {
    static let shared = APICaller()



    struct Constants {
        
        static let sourceURL = "https://newsapi.org/v2/everything?apiKey=\(Number.APINumber)&sources="
        
        static let searchURL = "https://newsapi.org/v2/everything?sources=\(UserDefaults.standard.value(forKey: "source") as! String)&apiKey=\(Number.APINumber)&q="
        
        static let sourceSearchURL = "https://newsapi.org/v2/everything?apiKey=\(Number.APINumber)&q="
    }

    private init() {}
    
    public func source(with query: String, completion: @escaping (Result<[Articles], Error>) -> Void) {
       
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        let urlString = Constants.sourceURL + query

        guard let url = URL(string: urlString) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)

                    print("Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }
    
    
    
    public func search(with query: String, completion: @escaping (Result<[Articles], Error>) -> Void) {
       
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        let urlString = Constants.searchURL + query

        guard let url = URL(string: urlString) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)

                    print("Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }
    
    public func sourceSearch(with query: String, completion: @escaping (Result<[Articles], Error>) -> Void) {
       
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        let urlString = Constants.sourceSearchURL + query

        guard let url = URL(string: urlString) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)

                    print("Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }
    
}

// Models

struct APIResponse: Codable {
    let articles: [Articles]
}

struct Articles: Codable {
//    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}

//struct Source: Codable {
//    let name: String
//}

