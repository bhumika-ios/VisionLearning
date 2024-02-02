//
//  ContentView.swift
//  VisionLearning
//
//  Created by Bhumika Patel on 01/02/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @State private var todoLists: [TodoList] = []
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
                    let list = TodoList(title: newTitle, items: [])
                    todoLists.append(list)
                }
            }
        } detail: {
            if let selectedTodoList{
                TodoListView(list: selectedTodoList)
            }
        }

    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
