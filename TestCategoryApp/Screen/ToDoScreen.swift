//
//  ToDoScreen.swift
//  TestCategoryApp
//
//  Created by Bhumika Patel on 20/01/23.
//

import SwiftUI
extension Group{
    public var itemsArray:[Todo]{
        let set = todos as? Set<Todo> ?? []
        return set.sorted{
            $0.doDate! < $1.doDate!
        }
    }
}
struct ToDoScreen: View {
    @FetchRequest(entity: Group.entity(), sortDescriptors: []) private var groups: FetchedResults<Group>
    
    @State private var searchValue = ""
    @State private var isAddGroupOpen = false
    @State private var isAddTodoOpen = false
    @State private var filteredByGroup: Group? = nil
    
    private let groupCardColumns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (spacing: 10) {
                    //LazyVGrid(columns: groupCardColumns, spacing: 10) {
                        ForEach(groups) {group in
                            NavigationLink(destination: {
                                List(group.itemsArray){todo in
                                    Text(todo.title ?? "")
                                    
                                }
                            }, label: {
                                GroupCardView(
                                    group: group,
                                    isFilteredByGroup: group == filteredByGroup,
                                    onGroupTap: { g in
                                        if filteredByGroup == g {
                                            filteredByGroup = nil
                                        } else {
                                            filteredByGroup = g
                                        }
                                    })
                            })
                            
                        }
                  //  }
                    
                    SectionTitleView(title: "")
                    
                    TodoList(query: searchValue, group: filteredByGroup)
                }
            }
            .padding(.leading)
            .padding(.trailing)
            //.searchable(text: $searchValue, placement: .toolbar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
//                ToolbarItem (placement: .navigationBarTrailing) {
//                    Button(action: { isAddGroupOpen = true }) {
//                        Image(systemName: "plus.rectangle.on.folder")
//                            .sheet (isPresented: $isAddGroupOpen) {
//                                PublishGroupScreen()
//                            }
//                    }
//                }
                ToolbarItem (placement: .primaryAction) {
                    Button(action: { isAddTodoOpen = true }) {
                        Image(systemName: "plus.circle")
                            .sheet(isPresented: $isAddTodoOpen) {
                                PublishTodoScreen()
                            }
                    }
                }
            }
            .navigationViewStyle(.automatic)
        }
    }
}

struct ToDoScreen_Previews: PreviewProvider {
    static var previews: some View {
        ToDoScreen()
    }
}
