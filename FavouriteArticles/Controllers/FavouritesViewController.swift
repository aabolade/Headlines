//
//  FavouritesViewController.swift
//  FavouriteArticles
//
//  Created by Leke Abolade on 02/04/2018.
//  Copyright © 2018 Leke Abolade. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    let dataSource = FavouritesDataSource()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        setUpSearchBar()
        
        title = "\(numberOfFavourites) Favourites"
        setUpDoneButton()
    }
    
    var numberOfFavourites: Int {
        return dataSource.numberOfFavourites
    }
    
    private func setUpDoneButton() {
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDoneButton))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func setUpSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        tableView.tableHeaderView = searchController.searchBar
    }
    
    @objc private func didTapDoneButton() {
        dismiss(animated: true, completion: nil)
    }
}

extension FavouritesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text!)
    }
}
