//
//  Category.swift
//  Todoey
//
//  Created by Vitaly Badion on 3/12/19.
//  Copyright © 2019 Vitaly Badion. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name = ""
    @objc dynamic var color = "" // DB ver.1
    let items = List<Item>()
}
