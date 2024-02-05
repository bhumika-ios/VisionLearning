//
//  Model.swift
//  VisionLearning
//
//  Created by Bhumika Patel on 01/02/24.
//

import Foundation
import SwiftData

@Model
class TodoList{
   
    var title: String
    
    @Relationship(deleteRule: .cascade)
    var items: [TodoItem] = []
    
    init(title: String) {
        self.title = title
    }
}

@Model
class TodoItem {
  
    var title : String
    var isDone : Bool = false
    
    init(title: String) {
        self.title = title
    }
    
}
