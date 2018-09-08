//
//  ViewController.swift
//  articleApp
//
//  Created by mp001 on 8/26/18.
//  Copyright © 2018 mp001. All rights reserved.
//

import UIKit


class ViewController: UIViewController,ArticlePresenterDelegate, UITableViewDelegate, UITableViewDataSource {
  
    var articelPresenter: ArticlePresenter?
    
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.articelPresenter = ArticlePresenter()
        self.articelPresenter?.delegate = self
        self.articelPresenter?.getArticles(page: 1, limit: 10)
     
    }
    
    @IBOutlet weak var articleTableView: UITableView!
    
    
    func responseArticle(articles: [Article]) {
        
        for article in articles{
            print(article.title!);
            
        }
        
        self.articles = articles
        DispatchQueue.main.async {
            self.articleTableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell") as! ArticleTableViewCell
        
        cell.configerCell(article: articles[indexPath.row])
    
        return cell
    }
    
    

   

}

