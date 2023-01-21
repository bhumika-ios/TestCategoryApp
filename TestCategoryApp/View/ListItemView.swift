//
//  ListItemView.swift
//  TestCategoryApp
//
//  Created by Bhumika Patel on 20/01/23.
//

import SwiftUI
import CoreData

struct ListItemView: View {
    @Environment(\.managedObjectContext) private var moc
    
    @ObservedObject var product: Product
    
    @State private var doesClose = false
    @State private var isEditProductOpen = false
    
    private func deleteProduct(object: NSManagedObject) {
        PersistenceController.shared.delete(context: moc, object: object)
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack (alignment: .leading, spacing: 5) {
                    HStack {
//                        CheckboxView(defaultChecked: todo.done, onToggle: {
//                            todo.toggle(context: moc)
//                        })
                        if product.title != nil {
                            Text(product.title!)
                                .onTapGesture {
                                    isEditProductOpen.toggle()
                                }
                                .sheet(isPresented: $isEditProductOpen) {
                                    PublishProductScreen(product: product)
                                }
                        }
                    }
                    
                    if product.category != nil {
                        //| \(todo.readableDoDate)
                        Text("\(product.category!.title!) ")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 14))
                    }
                }
                
                Spacer()
                
//                Image(systemName: "trash")
//                    .onTapGesture {
//                        deleteProduct(object: product)
//                    }
            }
            Divider()
        }
    }
}

let product = Product.createFakeTodo(category: Category())

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView(product: product)
            .previewLayout(.sizeThatFits)
    }
}
