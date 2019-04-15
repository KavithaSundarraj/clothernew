//
//  Collection.swift
//  Clother
//
//  Created by DSV on 2018-04-19.
//  Copyright © 2018 DSV. All rights reserved.
//

import Foundation
class Collections {
    var id: String?
    var name: String?
    var imageUrl: String?
    var itemurl: String?
    
    init(id: String?, name: String?, imageUrl: String?, itemurl: String?) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.itemurl = itemurl
    }
}
