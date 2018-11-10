//
//  ArticlePresenter.swift
//  articleApp
//
//  Created by mp001 on 8/26/18.
//  Copyright © 2018 mp001. All rights reserved.
//

import Foundation

class ArticlePresenter: ArticleServiceDelegate {
   
    
    var delegate: ArticlePresenterDelegate?
    
    var articleService: ArticleService?
    
    init() {
        self.articleService = ArticleService();
        self.articleService?.delegate = self
    }
    
    // ArticleServiceDelegate
    func responseArticel(articles: [Article]) {
     self.delegate?.responseArticle(articles: articles)
    }
    
    func getArticles(page: Int,limit: Int) {
        articleService?.getArticles(page: page, limit: limit)
    }
    
    func insertArticle(article: Article)  {
        articleService?.insertArticle(article: article)
    }
    
    func deleteArticle(id: Int) {
        articleService?.deleteArticle(id: id)
    }
    
    func responseMessage(message: String) {
        self.delegate?.responseMessage(message: message)
    }
    func uploadImage(data: Data, article: Article){
        
    }
    
}
