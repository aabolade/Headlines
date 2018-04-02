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
    
    var article: Article?
    var pageIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view, typically from a nib.
        
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureView() {
    
        guard let article = article else {
            return
        }
        
        headlineLabel.text = article.headline
        textLabel.text = article.text
        
        
        guard let image = article.image else {
            return
        }
        articleImage.image = image
    }
    
    @IBAction func didTapFavouriteButton(_ sender: UIButton) {
        
        guard let article = article else {
            return
        }
            
        toggleArticleFavourite(article)
        configureView()
    }
    
    private func toggleArticleFavourite(_ article: Article) {
        article.favourite = !article.favourite
        let buttonImage = article.favourite ? #imageLiteral(resourceName: "favourite-on") : #imageLiteral(resourceName: "favourite-off")
        favouriteButton.setImage(buttonImage, for: .normal)
    }
    
}

