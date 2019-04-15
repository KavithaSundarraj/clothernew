//
//  items.swift
//  Clother
//
//  Created by DSV on 2018-05-24.
//  Copyright © 2018 DSV. All rights reserved.
//

import Foundation
class items
{
    var itemId: String?
    var itemUrl:String?
    var itemDetailImagesUrl:[String]?
    var likes:Int?
    var dislikes:Int?
   
    init(itemId: String?, itemUrl: String?, itemDetailImagesUrl: [String]?) {
        self.itemId = itemId
        self.itemUrl = itemUrl
        self.itemDetailImagesUrl = itemDetailImagesUrl
        self.likes = 0
        self.dislikes = 0
}
}
