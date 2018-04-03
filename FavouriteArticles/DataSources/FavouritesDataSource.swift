//
//  FavouritesDataSource.swift
//  FavouriteArticles
//
//  Created by Leke Abolade on 02/04/2018.
//  Copyright © 2018 Leke Abolade. All rights reserved.
//

import Foundation
import UIKit

class FavouritesDataSource: NSObject, UITableViewDataSource {
    
    private var favourites: [Article] = []
    
    var numberOfFavourites: Int {
        return favourites.count
    }
    
    private let favouriteCellIdentifier = "FavouriteCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
