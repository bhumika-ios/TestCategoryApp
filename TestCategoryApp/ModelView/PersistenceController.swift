//
//  PersistenceController.swift
//  TestCategoryApp
//
//  Created by Bhumika Patel on 20/01/23.
//

import CoreData
import SwiftUI

extension PersistenceController {
    func createCategory(context: NSManagedObjectContext, title: String, symbolIcon: String, color: Color) {
        let category = Category(context: context)
        category.id = UUID()
        category.title = title
        category.color = color.toHex()
        category.systemIcon = symbolIcon

        self.save(context: context)
    }
}

extension PersistenceController {
    func createProduct(context: NSManagedObjectContext, category: Category, title: String, doDate: Date) {
        let newProduct = Product(context: context)
        newProduct.category = category
        newProduct.id = UUID()
        newProduct.title = title
      //  newTodo.createdAt = Date()
        newProduct.doDate = doDate
        
        self.save(context: context)
    }
}


