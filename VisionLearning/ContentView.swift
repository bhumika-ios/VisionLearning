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
    @Query private var todoLists: [TodoList]
    @State private var selectedTodoList: TodoList? = nil
    @State private var showAddListAlert: Bool = false
    @State private var newTitle : String = ""
    
    var body: some View {
        NavigationSplitView {
            List(todoLists){ list in
                Button(list.title){
                    selectedTodoList = list
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
                    let list = TodoList(title: newTitle)
                    modelContext.insert(list)
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

    }
}

#Preview {
    ContentView()
        .modelContainer(for: TodoList.self)
}
