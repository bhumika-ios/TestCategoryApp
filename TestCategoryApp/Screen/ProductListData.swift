//
//  ToDoListData.swift
//  TestCategoryApp
//
//  Created by Bhumika Patel on 20/01/23.
//

import SwiftUI

struct ProductListData: View {
    @State private var searchValue = ""
    @State private var filteredByCategory: Category? = nil
    @State private var isAddCategoryOpen = false
    @State private var isAddProductOpen = false
    var body: some View {
        NavigationView {
            ScrollView {
                SectionTitleView(title: "")
                
                ProductList(query: searchValue, category: filteredByCategory)
            }
        
        .padding(.leading)
        .padding(.trailing)
        .searchable(text: $searchValue, placement: .toolbar)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem (placement: .primaryAction) {
                Button(action: { isAddProductOpen = true }) {
                    Image(systemName: "plus.circle")
                        .sheet(isPresented: $isAddProductOpen) {
                            PublishProductScreen()
                        }
                    }
                }
            }
        }
    }
}

struct ToDoListData_Previews: PreviewProvider {
    static var previews: some View {
        ProductListData()
    }
}
