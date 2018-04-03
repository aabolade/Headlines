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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(numberOfFavourites) Favourites"
        setUpDoneButton()
    }
    
    var numberOfFavourites: Int {
        return dataSource.numberOfFavourites
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setUpDoneButton() {
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDoneButton))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc private func didTapDoneButton() {
        dismiss(animated: true, completion: nil)
    }

}
