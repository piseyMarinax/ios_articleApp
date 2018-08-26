//
//  Category.swift
//  articleApp
//
//  Created by mp001 on 8/26/18.
//  Copyright © 2018 mp001. All rights reserved.
//

import Foundation
import SwiftyJSON

class Category {
    var id: Int?
    var name: String?
    
    init() {}
    
    init(json: JSON) {
        self.id = json["ID"].int
        self.name = json["NAME"].string
    }
}
