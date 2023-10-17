//
//  Book.swift
//  ReadingManager
//
//  Created by 恵紙拓玖 on 2023/10/16.
//

import Foundation
import RealmSwift

class Book : Object {
    @objc dynamic var title : String! = ""
    @objc dynamic var category : String! = ""
    @objc dynamic var review : String! = "★★★★★"
    @objc dynamic var date : Date! = Date()
    @objc dynamic var dateView : String! = ""
    @objc dynamic var overview : String! = ""
    @objc dynamic var impression : String! = ""
    
}

