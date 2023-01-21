//
//  PublishGroupScreen.swift
//  TestCategoryApp
//
//  Created by Bhumika Patel on 20/01/23.
//

import SwiftUI

struct PublishCategoryScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.self) var env
    
    var category: Category? = nil
    
    @State private var title = ""
    @State private var color = Color.indigo
    @State private var systemIcon = "calendar"
    
    private let colors = [
        Color.indigo, Color.red, Color.blue, Color.cyan, Color.yellow,
        Color.green, Color.mint, Color.purple, Color.teal, Color.pink,
    ]
    
    private let systemIcons = [
        "calendar", "book.closed", "bookmark", "graduationcap", "cart",
        "display", "clock", "network", "phone", "heart"
    ]
    
    private let columns = Array(repeating: GridItem(spacing: 20), count: 5)
    
    private func publishCategory() {
        if category != nil {
            category?.title = title
            category?.systemIcon = systemIcon
            category?.color = color.toHex()
            
            PersistenceController.shared.save(context: moc)
        } else {
            PersistenceController.shared.createCategory(context: moc, title: title, symbolIcon: systemIcon, color: color)
        }
        
        dismiss()
    }
    
    init(category: Category? = nil) {
        if let safeCategory = category {
            self.category = safeCategory
            
            self._title = .init(initialValue: safeCategory.title!)
            self._color = .init(initialValue: Color(hex: safeCategory.color!)!)
            self._systemIcon = .init(initialValue: safeCategory.systemIcon!)
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (spacing: 20) {
                    VStack (alignment: .center, spacing: 20) {
                        CategoryIconView(systemIcon: systemIcon, color: color, size: .lg)
                        TextField("Title", text: $title)
                            .padding(10)
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(10)
                    }
                    .padding()
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(10)
                    
                    LazyVGrid (columns: columns, spacing: 20) {
                        ForEach(colors, id: \.self) { cl in
                            ZStack {
                                if cl.toHex()! == color.toHex()! {
                                    Circle()
                                        .foregroundColor(cl)
                                        .frame(width: 45, height: 45)
                                        .opacity(0.3)
                                }
                                
                                Circle()
                                    .foregroundColor(cl)
                                    .frame(width: 30, height: 30)
                                    .padding(15)
                            }
                            .onTapGesture {
                                withAnimation {
                                    self.color = cl
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(10)
                    
                    LazyVGrid (columns: columns, spacing: 20) {
                        ForEach(systemIcons, id: \.self) { icon in
                            CategoryIconView(systemIcon: icon, color: self.systemIcon == icon ? self.color : Color(UIColor.systemGray3))
                                .onTapGesture {
                                    withAnimation {
                                        self.systemIcon = icon
                                    }
                                }
                        }
                    }
                    .padding()
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(10)
                }
            }
            .padding()
            .toolbar {
                ToolbarItem (placement: .navigationBarLeading) {
                    Button (action: { dismiss() }) {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem (placement: .primaryAction) {
                    Button (action: publishCategory) {
                        Text("Done")
                    }
                    .disabled(title == "")
                }
            }
            .navigationTitle("Category")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
               // .overlay(alignment: .trailing){
                    Button{
                        if let editCategory =  category {
                            env.managedObjectContext.delete(editCategory)
                            try? env.managedObjectContext.save()
                            env.dismiss()
                        }
                        
                        
                    }label: {
                        Image(systemName: "trash")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .font(.title3)
                            .foregroundColor(.red)
                    }
                  //  .opacity(taskModel.editTask == nil ? 0 : 1)
               // }
            }
        }
    }
}

struct PublishGroupScreen_Previews: PreviewProvider {
    static var previews: some View {
        PublishCategoryScreen()
    }
}
