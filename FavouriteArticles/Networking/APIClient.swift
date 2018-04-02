//
//  APIClient.swift
//  FavouriteArticles
//
//  Created by Leke Abolade on 31/03/2018.
//  Copyright © 2018 Leke Abolade. All rights reserved.
//

import Foundation



class APIClient {
    
    let downloader = JSONDownloader()
    let APIKey = "enj8pstqu5yat6yesfsdmd39"
    
    enum Result {
        case success([[String: Any]])
        case failure
    }
    
    func fetchHeadlines(completion: @escaping ([Article]?, Error?) -> Void ) {
        
        guard let headlineURL = URL(string: "https://content.guardianapis.com/search?q=fintech&show-blocks=body&show-fields=headline,thumbnail&api-key=\(APIKey)") else {
            return
        }
        
        performRequest(with: headlineURL) { (result) in
            switch result {
            case .success(let results):
                let articles = results.flatMap { Article(json: $0) }
                completion(articles,nil)
            case .failure:
                completion(nil, nil)
            }
        }
    }
    
    private func performRequest(with url: URL, completion: @escaping(Result) -> Void ) {
        let task = downloader.jsonTask(with: url) { (json, error) in
            DispatchQueue.main.async {
                guard let json = json else {
                    completion(.failure)
                    return
                }
                
                guard let jsonResponse = json["response"] as? [String: Any], let jsonResults = jsonResponse["results"] as? [[String:Any]] else {
                    completion(.failure)
                    return
                }
                
                completion(.success(jsonResults))
            }
        }
        task.resume()
    }
}
