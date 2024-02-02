//
//  TodoListView.swift
//  VisionLearning
//
//  Created by Bhumika Patel on 02/02/24.
//

import SwiftUI

struct TodoListView: View {
    @State var list: TodoList
    @State private var showAddTodoAlert: Bool = false
    @State private var newTodoTitle: String = ""
    var body: some View {
        List(list.items) { item in
            Text (item.title)
        }
        .navigationTitle("Details for \(list.title)")
        .toolbar {
            Button ("Add Todo") {
                showAddTodoAlert.toggle()
            }
        }
        .alert("Add Todo", isPresented: $showAddTodoAlert) {
            TextField("Todo Title", text: $newTodoTitle)
            Button ("Cancel", role: .cancel, action: {})
            Button("Create"){
                let todo = TodoItem(title: newTodoTitle, isDone: false)
                list.items.append(todo)
            }
        }
        .id(list.id)
    }
}

//#Preview {
//    TodoListView()
//}
