//
//  CategoryIconView.swift
//  TestCategoryApp
//
//  Created by Bhumika Patel on 20/01/23.
//

import SwiftUI

enum CategoryIconSize {
    case md;
    case lg;
}

struct CategoryIconView: View {
    var systemIcon: String
    var color: Color
    var size: CategoryIconSize = .md
    
    var sizes: (frame: Double, icon: Double) {
        get {
            switch size {
            case .md:
                return (frame: 35, icon: 15)
            case .lg:
                return (frame: 50, icon: 20)
            }
        }
    }
    
    var body: some View {
        Circle()
            .fill(color)
            .frame(width: sizes.frame, height: sizes.frame)
            .overlay(
                Image(systemName: systemIcon)
                    .font(.system(size: sizes.icon))
                    .foregroundColor(.white)
            )
    }
}

struct CategoryIconView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryIconView(systemIcon: "calendar", color: Color.indigo)
            .previewLayout(.sizeThatFits)
    }
}
