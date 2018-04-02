//
//  Article.swift
//  FavouriteArticles
//
//  Created by Leke Abolade on 31/03/2018.
//  Copyright © 2018 Leke Abolade. All rights reserved.
//

import Foundation
import UIKit

class Article {
    
    let headline: String
    let text: String
    var image: UIImage?
    let imageURL: String
    let date: Date
    var favourite: Bool = false
    
    init(headline: String, text: String, imageURL: String, date: Date) {
        self.headline = headline
        self.text = text
        self.imageURL = imageURL
        self.date = date
    }
}

extension Article {
    
    convenience init?(json: [String: Any]) {
        
        struct Keys {
            static let fields = "fields"
            static let headline = "headline"
            static let body = "body"
            static let bodyTextSummary = "bodyTextSummary"
            static let thumbnail = "thumbnail"
            static let blocks = "blocks"
            static let publicationDate = "webPublicationDate"
        }
        
        guard let fields = json[Keys.fields] as? [String: Any], let headline = fields[Keys.headline] as? String else {
            return nil
        }
        
        guard let imageURL = fields[Keys.thumbnail] as? String else {
            return nil
        }
        
        guard let blocks = json[Keys.blocks] as? [String: Any], let body = blocks[Keys.body] as? [[String: Any]], let bodyText = body[0][Keys.bodyTextSummary] as? String else {
            return nil
        }
        
        guard let publicationDate = json[Keys.publicationDate] as? String else {
            return nil
        }
        
        guard let date = publicationDate.convertToDateObject else {
            return nil
        }
        
        self.init(headline: headline, text: bodyText, imageURL: imageURL, date: date)
    }
}

private extension String {
    var convertToDateObject: Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        return formatter.date(from: self)
    }
}
