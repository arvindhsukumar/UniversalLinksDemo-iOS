//
//  Author.swift
//  UniversalLinksDemo
//
//  Created by Arvindh Sukumar on 14/02/16.
//  Copyright © 2016 Arvindh Sukumar. All rights reserved.
//

import UIKit

class Author: NSObject {
    var name: String?
    var objectID: Int?
    
    convenience init(name:String?, objectID:Int?){
        self.init()
        self.name = name
        self.objectID = objectID
    }
}
