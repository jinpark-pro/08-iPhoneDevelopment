//
//  CoreDataExampleApp.swift
//  CoreDataExample
//
//  Created by Jungjin Park on 2024-07-02.
//

import SwiftUI

@main
struct CoreDataExampleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
