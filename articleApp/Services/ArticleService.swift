//
//  ArticleService.swift
//  articleApp
//
//  Created by mp001 on 8/26/18.
//  Copyright © 2018 mp001. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

//Reques URL using URLSession


//class ArticleService{
//    let ARTICEL_URL = 'http://35.240.238.182:8080/v1/api/articles'
//
//    var delegate: ArticleServiceDelegate?
//
//    func getArticles(page: Int, limit: Int) {
//        var request = URLRequest(url: URL(string: "\(ARTICEL_URL)?page=\(page)&&limit=\(limit)")!)
//
//        request.httpMethod = "GET"
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ=", forHTTPHeaderField: "Authorization")
//
//        let session = URLSession.shared
//
//        session.dataTask(with: request) { (data, response, error) in
//            if error == nil{
//                // data get success
//                let json = try? JSON(data: data!)
//                let articleJsonArray = json!["DATA"].array
//
//                var articles = [Article]()
//                for articelJson in articleJsonArray!{
//                    articles.append(Article(json: articelJson))
//                }
//
//                self.delegate?.responseArticel(articles: articles)
//
//            }
//        }.resume()
//    }
//
//    func insertArticle(article: Article) {
//        var request = URLRequest(url: URL(string: ARTICEL_URL)!)
//
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ=", forHTTPHeaderField: "Authorization")
//
//        let articleDict: [String: Any] = [
//            "TITLE": article.title!,
//            "DESCRIPTION": article.description!,
//            "AUTHOR": 1,
//            "CATEGORY_ID": 1,
//            "STATUS": "true",
//            "IMAGE": article.image!
//        ]
//        let articleData = try? JSONSerialization.data(withJSONObject: articleDict, options: [])
//
//        request.httpBody = articleData
//
//         let session = URLSession.shared
//
//        session.dataTask(with: request){ (data,response,error) in
//            if error == nil{
//                let json = try? JSON(data: data!)
//                let message = json!["MESSAGE"].string
//                self.delegate?.responseMessage(message: message!)
//            }
//        }.resume()
//    }
//
//    func deleteArticle(id: Int){
//        var request = URLRequest(url: URL(string: "\(ARTICEL_URL)/\(id)")!)
//
//        request.httpMethod = "DELETE"
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ=", forHTTPHeaderField: "Authorization")
//
//        let session = URLSession.shared
//
//        session.dataTask(with: request){ (data,response,error) in
//            if error == nil{
//                let json = try? JSON(data: data!)
//                let message = json!["MESSAGE"].string
//                self.delegate?.responseMessage(message: message!)
//            }
//        }.resume()
//    }
//}


class ArticleService{
    let ARTICEL_URL = "http://35.240.238.182:8080/v1/api/articles"
    let UPLOAD_URL = "http://35.240.238.182:8080/v1/api/uploadfile/single"
    
    var delegate: ArticleServiceDelegate?
    var HEADER = [
        "Authorization": "Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ=",
        "Accept": "application/json",
        "Content-Type": "application/json",
    ]

    func getArticles(page: Int, limit: Int) {
        Alamofire.request("\(ARTICEL_URL)?page=\(page)&&limit=\(limit)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.isSuccess{
                let json = try? JSON(data: response.data!)
                let articleJsonArray = json!["DATA"].array
                var articles = [Article]()
                for articelJson in articleJsonArray!{
                    articles.append(Article(json: articelJson))
                }
                self.delegate?.responseArticel(articles: articles)
            }
        }
    }
    
    func insertArticle(article: Article) {
        
        let parameters: Parameters = [
            "TITLE": article.title!,
            "DESCRIPTION": article.description!,
            "AUTHOR": 1,
            "CATEGORY_ID": 1,
            "STATUS": 1,
            "IMAGE": article.image!
        ]
        Alamofire.request("\(ARTICEL_URL)", method: .post, parameters: parameters,encoding: JSONEncoding(options: []),headers: HEADER).responseJSON { (response) in
            if response.result.isSuccess {
                print("Success");
                let json = try? JSON(data: response.data!)
                let message = json!["MESSAGE"].string
                self.delegate?.responseMessage(message: message!)
            }
        }
    }
    
    func deleteArticle(id: Int){
        Alamofire.request("\(ARTICEL_URL)/\(id)", method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.isSuccess{
                let json = try? JSON(data: response.data!)
                let message = json!["MESSAGE"].string
                self.delegate?.responseMessage(message: message!)
            }
        }
    }
    
    func uploadImage(data: Data, article: Article) {
        
        Alamofire.upload(multipartFormData: { (formData) in
            formData.append(data, withName: "FILE", fileName: ".jpg",
                            mimeType: "image/*")
        }, to: UPLOAD_URL, method: .post, headers: HEADER) { (result) in
            switch result{
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                upload.responseJSON(completionHandler: { (respone) in
                    let json = try? JSON(data: respone.data!)
                    let imageURL = json!["DATA"].string
                    article.image = imageURL!
                    self.insertArticle(article: article )
                })
            case .failure(let error):
                print("Error UPLOAD",error)
            }
        }
    }
}

