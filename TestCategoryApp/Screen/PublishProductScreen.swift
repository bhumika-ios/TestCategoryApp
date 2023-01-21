//
//  PublishTodoScreen.swift
//  TestCategoryApp
//
//  Created by Bhumika Patel on 20/01/23.
//

import SwiftUI

struct PublishProductScreen: View {
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.dismiss) private var dismiss
    @Environment(\.self) var env
    
    @FetchRequest(entity: Category.entity(), sortDescriptors: []) private var categories: FetchedResults<Category>
    
    @State private var title = ""
    @State private var category: UUID?
    @State private var date = Date()
    @State private var isAddCategoryOpen = false
    @State private var isEditProductOpen = false
    
    var product: Product? = nil
    
    init (product: Product? = nil) {
        if let safeProduct = product {
            self.product = safeProduct
            self._title = .init(initialValue: safeProduct.title!)
            self._date = .init(initialValue: safeProduct.doDate!)
            self._category = .init(initialValue: safeProduct.category!.id)
        }
    }
    
    private func publishProduct() {
        if self.category == nil {
            return
        }
        
        let selectedCategory = categories.first(where: {$0.id == self.category!})
        
        if product != nil {
            product?.title = title
            product?.category = selectedCategory
            product?.doDate = date
            
            PersistenceController.shared.save(context: moc)
        } else {
            PersistenceController.shared.createProduct(context: moc, category: selectedCategory!, title: title, doDate: date)
        }
        
        dismiss()
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                
                HStack{
                    Picker("Select Group", selection: $category) {
                        ForEach(categories) {
                            Text($0.title!).tag($0.id)
                        }
                    }
                    
               
//                    
               }
                
//                DatePicker(
//                    "Do Date",
//                    selection: $date,
//                    displayedComponents: [.date]
//                )
            }
            .toolbar {
                ToolbarItem (placement: .navigationBarLeading) {
                    Button (action: { dismiss() }) {
                        Text("Cancel")
                    }
                }
//                ToolbarItem (placement: .navigationBarTrailing) {
//                    Button(action: { isAddGroupOpen = true }) {
//                        Image(systemName: "plus.circle")
//                            .sheet (isPresented: $isAddGroupOpen) {
//                                PublishGroupScreen()
//                            }
//                    }
//                }
              
                ToolbarItem (placement: .primaryAction) {
                    Button (action: publishProduct) {
                        Text("Done")
                    }
                    .disabled(title == "")
                }
               
            }
            .navigationTitle("Product")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
               // .overlay(alignment: .trailing){
                    Button{
                        if let editProduct =  product {
                            env.managedObjectContext.delete(editProduct)
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

struct PublishTodoScreen_Previews: PreviewProvider {
    static var previews: some View {
        PublishProductScreen()
    }
}

struct GroupAdd: View{
    @State private var isAddGroupOpen = false
    var body: some View{
        VStack{
            Button(action: { isAddGroupOpen = true }) {
                Image(systemName: "plus")
                    .sheet (isPresented: $isAddGroupOpen) {
                        PublishCategoryScreen()
                    }
            }
        }
    }
}
