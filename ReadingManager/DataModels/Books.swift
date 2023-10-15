//
//  Books.swift
//  ReadingManager
//
//  Created by 恵紙拓玖 on 2023/10/16.
//

import Foundation
import RealmSwift

class Books : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var review : String = "★★★★★"
    let contentsOfBook = Content()
}
