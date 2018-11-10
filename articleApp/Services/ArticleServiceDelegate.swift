//
//  ArticleServiceDelegate.swift
//  articleApp
//
//  Created by mp001 on 8/26/18.
//  Copyright © 2018 mp001. All rights reserved.
//

import Foundation

protocol ArticleServiceDelegate {
    func responseArticel(articles: [Article])
    func responseMessage(message: String)
}
