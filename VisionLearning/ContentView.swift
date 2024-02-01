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
                    let list = TodoList(title: "List\(todoLists.count)", items: [])
                    todoLists.append(list )
                }, label: {
                    Image(systemName: "plus")
                })
               
            }
        } detail: {
            
        }

    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
