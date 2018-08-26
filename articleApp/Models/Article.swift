//
//  Article.swift
//  articleApp
//
//  Created by mp001 on 8/26/18.
//  Copyright © 2018 mp001. All rights reserved.
//

import Foundation
import SwiftyJSON

class Article{
    var id: Int?
    var title: String?
    var description: String?
    var category: Category?
    var image: String?
    
    init() {}
    
    init(json: JSON) {
        self.id = json["ID"].int
        self.title = json["TITLE"].string
        self.description = json["DESCRIPTION"].string
        self.category = Category(json: json["CATEGORY"])
        self.image = json["IMAGE"].string
    }

}
