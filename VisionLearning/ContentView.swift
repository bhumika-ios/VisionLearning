//
//  ContentView.swift
//  VisionLearning
//
//  Created by Bhumika Patel on 01/02/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment (\.modelContext) private var modelContext
    @Query private var initialTodoLists: [TodoList]
    @State private var todoLists: [TodoList] = []
    @State private var selectedTodoList: TodoList? = nil
    @State private var showAddListAlert: Bool = false
    @State private var newTitle : String = ""
    @State private var isEditingList: Bool = false
    @State private var updatedTitle: String = ""
    @State private var editedTitle: String = ""
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(todoLists) { list in
                    Button(action: {
                        selectedTodoList = list
                    }) {
                        Text(list.title)
                    }
                    .contextMenu {
                        Button("Delete") {
                            deleteTodoList(list)
                        }
                        Button("Edit") {
                            editedTitle = list.title
                            isEditingList.toggle()
                        }
                    }
                }
            }
            .navigationTitle("TodoList")
            .toolbar{
                Button(action: {
                    showAddListAlert.toggle()
                }, label: {
                    Image(systemName: "plus")
                })
                
            }
            .alert("Add TodoList", isPresented: $showAddListAlert){
                TextField("Title", text: $newTitle)
                Button("Cancel", role: .cancel, action: {})
                Button("Add"){
                    let newList = TodoList(title: newTitle)
                    modelContext.insert(newList)
                    updateTodoLists()
                    newTitle = "" // Clear the input field
                }
            }
            .alert("Edit TodoList", isPresented: $isEditingList) {
                TextField("Title", text: $editedTitle)
                Button("Cancel", role: .cancel, action: {})
                Button("Update") {
                    editTodoList()
                }
            }
        } detail: {
            if let selectedTodoList = selectedTodoList {
                TodoListView(list: selectedTodoList)
                    .id(selectedTodoList.id) // Use id to force update when selectedTodoList changes
            } else {
                Text("Select a TodoList")
            }
        }
        .onAppear {
            updateTodoLists()
        }
        
    }
    private func updateTodoLists() {
        todoLists = initialTodoLists
    }
    private func deleteTodoList(_ list: TodoList) {
        if let index = todoLists.firstIndex(where: { $0.id == list.id }) {
            modelContext.delete(todoLists.remove(at: index))
            selectedTodoList = nil
        }
    }
    private func editTodoList() {
        if let selectedList = selectedTodoList,
           let index = todoLists.firstIndex(where: { $0.id == selectedList.id }) {
            todoLists[index].title = editedTitle
            selectedTodoList = nil
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: TodoList.self)
}
