//
//  comp3097_labtest1App.swift
//  comp3097-labtest1
//
//  Created by Nhan Tran on 2025-02-10.
//

import SwiftUI

@main
struct comp3097_labtest1App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
