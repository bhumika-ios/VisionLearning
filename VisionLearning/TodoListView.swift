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
        List{
            Section("Todo"){
                ForEach(list.items.filter{ $0.isDone == false }) { item in
                    HStack{
                        Button {
                            if let itemIndex = list.items.firstIndex(where: { $0.id == item.id }){
                                withAnimation{
                                    list.items[itemIndex].isDone.toggle()
                                }
                            }
                        } label: {
                            Image (systemName: item.isDone ? "circle.fill" : "circle")
                        }
                        Text(item.title)
                        Spacer ()
                    }
                }
            }
            Section("Done"){
                ForEach(list.items.filter{ $0.isDone }) { item in
                    HStack{
                        Button {
                            if let itemIndex = list.items.firstIndex(where: { $0.id == item.id }){
                                withAnimation{
                                    list.items[itemIndex].isDone.toggle()
                                }
                            }
                        } label: {
                            Image (systemName: item.isDone ? "circle.fill" : "circle")
                        }
                        Text(item.title)
                        Spacer ()
                    }
                }
            }
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
