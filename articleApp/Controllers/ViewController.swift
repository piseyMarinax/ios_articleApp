//
//  ViewController.swift
//  articleApp
//
//  Created by mp001 on 8/26/18.
//  Copyright © 2018 mp001. All rights reserved.
//

import UIKit


class ViewController: UIViewController,ArticlePresenterDelegate {
  
    
  
    var articelPresenter: ArticlePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.articelPresenter = ArticlePresenter()
        self.articelPresenter?.delegate = self
        self.articelPresenter?.getArticles(page: 1, limit: 10)
     
    }
    
    func responseArticle(articles: [Article]) {
        for article in articles{
            print(article.title);
            print(article.description);
            
        }
       
    }
    
    

   

}

