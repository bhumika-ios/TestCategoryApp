//
//  CatgoryItem+CoreDataProperties.swift
//  TestCategoryApp
//
//  Created by Bhumika Patel on 19/01/23.
//
//

import Foundation
import CoreData


extension CatgoryItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CatgoryItem> {
        return NSFetchRequest<CatgoryItem>(entityName: "CatgoryItem")
    }

    @NSManaged public var color: String?
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var categoryToItem: NSSet?

}

// MARK: Generated accessors for categoryToItem
extension CatgoryItem {

    @objc(addCategoryToItemObject:)
    @NSManaged public func addToCategoryToItem(_ value: Item)

    @objc(removeCategoryToItemObject:)
    @NSManaged public func removeFromCategoryToItem(_ value: Item)

    @objc(addCategoryToItem:)
    @NSManaged public func addToCategoryToItem(_ values: NSSet)

    @objc(removeCategoryToItem:)
    @NSManaged public func removeFromCategoryToItem(_ values: NSSet)

}

extension CatgoryItem : Identifiable {

}
