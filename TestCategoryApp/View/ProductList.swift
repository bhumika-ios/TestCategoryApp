//
//  TodoList.swift
//  TestCategoryApp
//
//  Created by Bhumika Patel on 20/01/23.
//

import SwiftUI

struct ProductList: View {
    @FetchRequest private var products: FetchedResults<Product>
    
    var body: some View {
        ForEach(products) { product in
            ListItemView(product: product)
        }
    }
    
    init(query: String, category: Category? = nil) {
        let sortByDate = NSSortDescriptor(key: #keyPath(Product.doDate), ascending: false)
        
        if category != nil {
            if query.isEmpty {
                _products = FetchRequest<Product>(sortDescriptors: [sortByDate], predicate: NSPredicate(format: "category = %@", category!))
            } else {
                _products = FetchRequest<Product>(sortDescriptors: [sortByDate], predicate: NSPredicate(format: "category = %@ && title CONTAINS[cd] %@", category!, query))
            }
        } else if !query.isEmpty {
            _products = FetchRequest<Product>(sortDescriptors: [sortByDate], predicate: NSPredicate(format: "title CONTAINS[cd] %@", query))
        } else {
            _products = FetchRequest<Product>(sortDescriptors: [sortByDate])
        }
    }
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        ProductList(query: "")
    }
}
