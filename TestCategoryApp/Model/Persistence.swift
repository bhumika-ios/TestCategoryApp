//
//  Persistence.swift
//  TestCategoryApp
//
//  Created by Bhumika Patel on 20/01/23.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        var groups: [Category] = []
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<3 {
            let newGroup = Category.createFakeGroup(context: viewContext)
            
            groups.append(newGroup)
        }
        
        for _ in 0..<3 {
            let newTodo = Product.createFakeTodo(category: groups[Int.random(in: 0..<groups.count)], context: viewContext)
        }
        
        result.save(context: viewContext)
        
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "TestCategoryApp")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func delete(context: NSManagedObjectContext, object: NSManagedObject) {
        context.delete(object)
        
        self.save(context: context)
    }
    
    func save(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Can`t save changes: \(error.localizedDescription)")
            }
        }
    }
}
