//
//  NewCategorySheet.swift
//  Kaizen
//
//  Created by Tansu ICIN on 16.12.2023.
//

import SwiftUI

struct NewCategorySheet: View {
    @State private var newCategory = Category.emptyNote
    @Binding var categories: [Category]
    @Binding var isPresentingNewScrumView: Bool
    
    var body: some View {
        NavigationStack {
            DetailEditView(category: $newCategory)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentingNewScrumView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            categories.append(newCategory)
                            isPresentingNewScrumView = false
                        }
                    }
                }
        }
    }
}

struct NewCategorySheet_Previews: PreviewProvider {
    static var previews: some View {
        NewCategorySheet(categories: .constant(Category.sampleData), isPresentingNewScrumView: .constant(true))
    }
}
