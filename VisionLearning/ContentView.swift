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
    var body: some View {
        NavigationSplitView {
            List(todoLists){ list in
                
            }
        } detail: {
            <#code#>
        }

    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
