//
//  TestCategoryAppApp.swift
//  TestCategoryApp
//
//  Created by Bhumika Patel on 19/01/23.
//

import SwiftUI

@main
struct TestCategoryAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
