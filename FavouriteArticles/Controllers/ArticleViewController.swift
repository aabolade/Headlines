//
//  ViewController.swift
//  FavouriteArticles
//
//  Created by Leke Abolade on 31/03/2018.
//  Copyright © 2018 Leke Abolade. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
    
    @IBOutlet private weak var headlineLabel: UILabel!
    
    @IBOutlet private weak var textLabel: UILabel!
    
    @IBOutlet private weak var articleImage: UIImageView!
    
    @IBOutlet weak var favouriteButton: UIButton!
    
    var headline: Headline!
    var pageIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    func configureView() {
        
        headlineLabel.text = headline.title
        textLabel.text = headline.text

        
        guard let image = headline.image else {
            return
        }
        articleImage.image = image
        
        updateFavouriteButton()
    }
    
    @IBAction func didTapFavouriteButton(_ sender: UIButton) {
        
        updateHeadline()
        updateFavouriteButton()
        configureView()
    }
    
    private func updateFavouriteButton() {
        let buttonImage = headline.favourite ? #imageLiteral(resourceName: "favourite-on") : #imageLiteral(resourceName: "favourite-off")
        favouriteButton.setImage(buttonImage, for: .normal)
    }
    
    private func updateHeadline() {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext else {
            return
        }
        headline.favourite = !headline.favourite

        do {
            try context.save()
        } catch let error {
            print(error.localizedDescription)
        }

    }
}

