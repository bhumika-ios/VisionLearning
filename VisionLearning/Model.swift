//
//  Model.swift
//  VisionLearning
//
//  Created by Bhumika Patel on 01/02/24.
//

import Foundation

struct TodoList: Identifiable{
    let id = UUID()
    let title: String
    
    let items: [TodoItem]
}
struct  TodoItem: Identifiable {
    let id = UUID()
    let title : String
    var isDone : Bool
}
