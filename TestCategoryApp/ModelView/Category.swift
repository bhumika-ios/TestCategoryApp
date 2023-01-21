//
//  Group.swift
//  TestCategoryApp
//
//  Created by Bhumika Patel on 20/01/23.
//

import Foundation
import CoreData

extension Category {
    static func createFakeGroup(context: NSManagedObjectContext? = nil) -> Category {
        let category = context != nil ? Category(context: context!) : Category()
        category.id = UUID()
        category.title = "Some Group"
        category.color = "#2f42d6"
        category.systemIcon = "list.bullet.circle.fill"
        
        return category
    }
}

