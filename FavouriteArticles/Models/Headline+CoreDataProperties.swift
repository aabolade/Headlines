//
//  Headline+CoreDataProperties.swift
//  FavouriteArticles
//
//  Created by Leke Abolade on 06/04/2018.
//  Copyright © 2018 Leke Abolade. All rights reserved.
//
//

import Foundation
import CoreData


extension Headline {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Headline> {
        return NSFetchRequest<Headline>(entityName: "Headline")
    }

    @NSManaged public var title: String
    @NSManaged public var text: String
    @NSManaged public var imageURL: String
    @NSManaged public var publishDate: Date
    @NSManaged public var favourite: Bool

}
