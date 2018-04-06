//
//  ArticlesPageViewController.swift
//  FavouriteArticles
//
//  Created by Leke Abolade on 31/03/2018.
//  Copyright © 2018 Leke Abolade. All rights reserved.
//

import UIKit
import CoreData

class ArticlesPageViewController: UIPageViewController {
    
    let apiClient = APIClient()
    var articles = Stub.articles
    var headlines = [Headline]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        loadHeadlines()
        setArticleImages()
    }
    
    private func saveHeadlines(articles: [Article]) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext else {
            return
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Headline", in: context) else {
            return
        }
        
        articles.forEach({ (article) in
            let headline = Headline(context: context)
            
            self.configure(headline: headline, with: article)
        })
        
        do {
            try context.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func loadHeadlines() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Headline")
        
        do {
            headlines = try managedContext.fetch(fetchRequest) as! [Headline]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    private func configure(headline: Headline, with article: Article) {
        headline.title = article.headline
        headline.text = article.text
        headline.favourite = article.favourite
        headline.imageURL = article.imageURL
        headline.publishDate = article.date
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setUpFirstViewController() {
        guard let firstViewController = self.articleViewController(at: 0) else {
            return
        }
        self.setViewControllers([firstViewController], direction: .forward, animated: false, completion: nil)
    }
    
    private func setArticleImages() {
        headlines.forEach { (headline) in
            guard let imageURL = URL(string: headline.imageURL) else { return }
            
            DispatchQueue.global().async { [unowned self] in
                do {
                    let imageData = try Data(contentsOf: imageURL)
                    
                    DispatchQueue.main.async { [unowned self] in
                        headline.image = UIImage(data: imageData)
                        self.setUpFirstViewController()
                    }
                } catch let error {
                    print(error)
                }
            }
        }
    }
}

extension ArticlesPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let articleViewController = viewController as? ArticleViewController else {
            return nil
        }
        
        guard let currentIndex = articleViewController.pageIndex else {
            return nil
        }
        
        let previousIndex = currentIndex - 1
        
        if previousIndex < 0 || previousIndex >= articles.count {
            return nil
        }
        
        return self.articleViewController(at: previousIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let articleViewController = viewController as? ArticleViewController else {
            return nil
        }
        
        guard let currentIndex = articleViewController.pageIndex else {
            return nil
        }
        
        let nextIndex = currentIndex + 1
        
        if nextIndex >= articles.count {
            return nil
        }
        
        return self.articleViewController(at: nextIndex)
    }
    
    func articleViewController(at index: Int) -> ArticleViewController? {
        let headline = headlines[index]
        
        guard let articleViewController = storyboard?.instantiateViewController(withIdentifier: "ArticleViewController") as? ArticleViewController else {
            return nil
        }
        
        articleViewController.pageIndex = index
        articleViewController.headline = headline
        
        return articleViewController
    }
}
