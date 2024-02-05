//
//  VisionLearningApp.swift
//  VisionLearning
//
//  Created by Bhumika Patel on 01/02/24.
//

import SwiftUI
import SwiftData

@main
struct VisionLearningApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: TodoList.self)
    }
}
