//
//  TodoListView.swift
//  VisionLearning
//
//  Created by Bhumika Patel on 02/02/24.
//

import SwiftUI
import SwiftData

struct TodoListView: View {
    @Environment (\.modelContext) private var modelContext
    @State var list: TodoList
    @State private var showAddTodoAlert: Bool = false
    @State private var newTodoTitle: String = ""
    
    var body: some View {
        List {
                   Section("Todo") {
                       ForEach(list.items.filter { !$0.isDone }) { item in
                           TodoItemRow(item: item, list: list)
                       }
                   }
                   Section("Done") {
                       ForEach(list.items.filter { $0.isDone }) { item in
                           TodoItemRow(item: item, list: list)
                       }
                   }
               }
        .navigationTitle("Details for \(list.title)")
        .toolbar {
        Button ("Add Todo") {
        showAddTodoAlert.toggle()
            }
        }
        .alert( "Add Todo", isPresented: $showAddTodoAlert) {
        TextField("Todo Title", text: $newTodoTitle)
            Button ("Cancel", role: .cancel, action: {})
            Button ("Create") {
                let todo = TodoItem(title: newTodoTitle)
                modelContext.insert (todo)
                list.items.append (todo)
            }
            
        }
        .id(list.id)
    }
    
}
struct TodoItemRow: View {
    @Environment(\.modelContext) private var modelContext
    var item: TodoItem
    var list: TodoList
    @State private var isEditing: Bool = false
    @State private var editedTitle: String = ""
    var body: some View {
        HStack {
            Button {
                toggleTodoItemCompletion()
            } label: {
                Image(systemName: item.isDone ? "circle.fill" : "circle")
            }
            Text(item.title)
                .foregroundStyle(.green)
            Spacer()
//            Button("Delete") {
//                deleteTodoItem()
//            }
        }
        .contextMenu(ContextMenu(menuItems: {
            Button{
                deleteTodoItem()
            } label: {
                HStack{
                    Image(systemName: "trash")
                      
                      
                    Text("Delete")
                       
                        
                }
                .foregroundColor(.red)
            }
            if !item.isDone {
                Button("Edit"){
                    isEditing = true
                }
            }
        }))
        .alert( "Edit Todo", isPresented: $isEditing) {
        TextField("Todo Title", text: $editedTitle)
            Button ("Cancel", role: .cancel, action: {})
            Button ("Update") {
                updateTodoItemTitle()
            }
            
        }
        .id(list.id)
    }

    private func deleteTodoItem() {
           if let index = list.items.firstIndex(where: { $0.id == item.id }) {
               modelContext.delete(list.items.remove(at: index))
           }
       }

    private func toggleTodoItemCompletion() {
           if let index = list.items.firstIndex(where: { $0.id == item.id }) {
               list.items[index].isDone.toggle()
           }
       }
    private func updateTodoItemTitle() {
            if let index = list.items.firstIndex(where: { $0.id == item.id }) {
                list.items[index].title = editedTitle
               
            }
        }
}
//#Preview {
//    TodoListView()
//}
