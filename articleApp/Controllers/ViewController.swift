//
//  ViewController.swift
//  articleApp
//
//  Created by mp001 on 8/26/18.
//  Copyright © 2018 mp001. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    
    var articelPresenter: ArticlePresenter?
    
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.articelPresenter = ArticlePresenter()
        self.articelPresenter?.delegate = self
        
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.articelPresenter?.getArticles(page: 1, limit: 30)
    }
    
    @IBOutlet weak var articleTableView: UITableView!
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell") as! ArticleTableViewCell
        
        cell.configerCell(article: articles[indexPath.row])
    
        return cell
    }
    
}

extension ViewController: ArticlePresenterDelegate{
    
    func responseMessage(message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle:  .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func responseArticle(articles: [Article]) {
        
        self.articles = articles
        DispatchQueue.main.async {
            self.articleTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .normal, title: "Edit"){ (action,indexPath) in
            
        }
        let delete = UITableViewRowAction(style: .destructive, title: "Delete"){ (action,indexPath) in
            //Delete article code goes here
            self.articelPresenter?.deleteArticle(id: self.articles[indexPath.row].id!)
            self.articles.remove(at: indexPath.row)
            self.articleTableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        return [edit,delete];
    }
}

