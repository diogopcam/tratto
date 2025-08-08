//
//  swiftui_challengeApp.swift
//  swiftui-challenge
//
//  Created by Diogo Camargo on 05/08/25.
//

import SwiftUI
import SwiftData

@main
struct swiftui_challengeApp: App {
    let container = try! ModelContainer(for: Collection.self, Reference.self)
    
    var body: some Scene {
        WindowGroup {
            TabBar()
                .modelContainer(container)  
        }
    }
}
