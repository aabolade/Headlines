//
//  JSONDownloader.swift
//  FavouriteArticles
//
//  Created by Leke Abolade on 31/03/2018.
//  Copyright © 2018 Leke Abolade. All rights reserved.
//

import Foundation

class JSONDownloader {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    typealias JSON = [String: AnyObject]
    typealias JSONTaskCompletionHandler = (JSON?,ArticleError?) -> Void
    
    func jsonTask(with url: URL, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            guard 200 ... 299 ~= httpResponse.statusCode else {
                completion(nil, .requestFailed)
                return
            }
            
            guard let data = data else {
                completion(nil, .requestFailed)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
                completion(json, nil)
            } catch {
                completion(nil, .requestFailed)
            }    
            
        }
        return task
    }
}
