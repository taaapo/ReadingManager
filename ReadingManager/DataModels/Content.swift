//
//  Content.swift
//  ReadingManager
//
//  Created by 恵紙拓玖 on 2023/10/16.
//

import Foundation
import RealmSwift

class Content : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var category : String = ""
    @objc dynamic var review : String = "★★★★★"
    @objc dynamic var overview : String = ""
    @objc dynamic var impression : String = ""
    var parentBook = LinkingObjects(fromType: Books.self, property: "contentsOfBook")
}
