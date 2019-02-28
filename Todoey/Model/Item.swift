//
//  ToDoItem.swift
//  Todoey
//
//  Created by Vitaly Badion on 2/26/19.
//  Copyright © 2019 Vitaly Badion. All rights reserved.
//

import Foundation

class Item: Codable {
    var title: String
    var done: Bool
    
    init(title: String, done: Bool = false) {
        self.title = title
        self.done = done
    }
}
