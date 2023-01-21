//
//  Todo.swift
//  TestCategoryApp
//
//  Created by Bhumika Patel on 20/01/23.
//

import Foundation
import CoreData
// import SwiftUI

extension Product {
    static func createFakeTodo(category: Category, context: NSManagedObjectContext? = nil) -> Product {
        let newProduct = context != nil ? Product(context: context!) : Product()
        newProduct.category = category
        newProduct.id = UUID()
        newProduct.title = "Some Todo"
      //  newTodo.createdAt = Date()
        newProduct.doDate = Date()
        
        return newProduct
    }
    
    var readableDoDate: String {
        get {
            let df = DateFormatter()
            df.dateFormat = "MMM dd,yyyy"
            
            if (self.doDate != nil) {
                return df.string(from: self.doDate!)
            }
            
            return ""
        }
    }
    
    func toggle(context: NSManagedObjectContext) {
        self.done.toggle()
        
        PersistenceController.shared.save(context: context)
    }
}
