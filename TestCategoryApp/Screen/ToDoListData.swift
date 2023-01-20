//
//  ToDoListData.swift
//  TestCategoryApp
//
//  Created by Bhumika Patel on 20/01/23.
//

import SwiftUI

struct ToDoListData: View {
    @State private var searchValue = ""
    @State private var filteredByGroup: Group? = nil
    @State private var isAddGroupOpen = false
    @State private var isAddTodoOpen = false
    var body: some View {
        NavigationView {
            ScrollView {
                SectionTitleView(title: "")
                
                TodoList(query: searchValue, group: filteredByGroup)
            }
        
        .padding(.leading)
        .padding(.trailing)
        .searchable(text: $searchValue, placement: .toolbar)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem (placement: .primaryAction) {
                Button(action: { isAddTodoOpen = true }) {
                    Image(systemName: "plus.circle")
                        .sheet(isPresented: $isAddTodoOpen) {
                            PublishTodoScreen()
                        }
                    }
                }
            }
        }
    }
}

struct ToDoListData_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListData()
    }
}
