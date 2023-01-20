//
//  PublishTodoScreen.swift
//  TestCategoryApp
//
//  Created by Bhumika Patel on 20/01/23.
//

import SwiftUI

struct PublishTodoScreen: View {
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.dismiss) private var dismiss
    
    @FetchRequest(entity: Group.entity(), sortDescriptors: []) private var groups: FetchedResults<Group>
    
    @State private var title = ""
    @State private var group: UUID?
    @State private var date = Date()
    @State private var isAddGroupOpen = false
    
    var todo: Todo? = nil
    
    init (todo: Todo? = nil) {
        if let safeTodo = todo {
            self.todo = safeTodo
            self._title = .init(initialValue: safeTodo.title!)
            self._date = .init(initialValue: safeTodo.doDate!)
            self._group = .init(initialValue: safeTodo.group!.id)
        }
    }
    
    private func publishTodo() {
        if self.group == nil {
            return
        }
        
        let selectedGroup = groups.first(where: {$0.id == self.group!})
        
        if todo != nil {
            todo?.title = title
            todo?.group = selectedGroup
            todo?.doDate = date
            
            PersistenceController.shared.save(context: moc)
        } else {
            PersistenceController.shared.createTodo(context: moc, group: selectedGroup!, title: title, doDate: date)
        }
        
        dismiss()
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                HStack{
                    Picker("Select Group", selection: $group) {
                        ForEach(groups) {
                            Text($0.title!).tag($0.id)
                        }
                    }
                    
               
                    
                }
                
                DatePicker(
                    "Do Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
            }
            .toolbar {
                ToolbarItem (placement: .navigationBarLeading) {
                    Button (action: { dismiss() }) {
                        Text("Cancel")
                    }
                }
                ToolbarItem (placement: .navigationBarTrailing) {
                    Button(action: { isAddGroupOpen = true }) {
                        Image(systemName: "plus.circle")
                            .sheet (isPresented: $isAddGroupOpen) {
                                PublishGroupScreen()
                            }
                    }
                }
              
                ToolbarItem (placement: .primaryAction) {
                    Button (action: publishTodo) {
                        Text("Done")
                    }
                    .disabled(title == "")
                }
               
            }
            .navigationTitle("Publish Todo")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct PublishTodoScreen_Previews: PreviewProvider {
    static var previews: some View {
        PublishTodoScreen()
    }
}

struct GroupAdd: View{
    @State private var isAddGroupOpen = false
    var body: some View{
        VStack{
            Button(action: { isAddGroupOpen = true }) {
                Image(systemName: "plus")
                    .sheet (isPresented: $isAddGroupOpen) {
                        PublishGroupScreen()
                    }
            }
        }
    }
}
