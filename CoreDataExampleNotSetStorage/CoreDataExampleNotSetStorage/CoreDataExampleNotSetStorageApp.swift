//
//  CoreDataExampleNotSetStorageApp.swift
//  CoreDataExampleNotSetStorage
//
//  Created by Jungjin Park on 2024-07-02.
//

import SwiftUI

@main
struct CoreDataExampleNotSetStorageApp: App {
    let coreDM = CoreDataManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDM.persistentContainer.viewContext)
        }
    }
}
