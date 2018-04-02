//
//  ArticlesPageViewController.swift
//  FavouriteArticles
//
//  Created by Leke Abolade on 31/03/2018.
//  Copyright © 2018 Leke Abolade. All rights reserved.
//

import UIKit

class ArticlesPageViewController: UIPageViewController {
    
    let apiClient = APIClient()
    var articles = Stub.articles

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        apiClient.fetchHeadlines { [unowned self] (articles, error) in
            
            guard let articles = articles else {
                return
            }
            
            self.setArticleImages(articles)
        }
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
    
    private func setArticleImages(_ articles: [Article]) {
        articles.forEach { (article) in
            guard let imageURL = URL(string: article.imageURL) else { return }
            
            DispatchQueue.global().async { [unowned self] in
                do {
                    let imageData = try Data(contentsOf: imageURL)
                    
                    DispatchQueue.main.async { [unowned self] in
                        article.image = UIImage(data: imageData)
                        self.articles = articles
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
        let article = articles[index]
        
        guard let articleViewController = storyboard?.instantiateViewController(withIdentifier: "ArticleViewController") as? ArticleViewController else {
            return nil
        }
        
        articleViewController.pageIndex = index
        articleViewController.article = article
        
        return articleViewController
    }
}
