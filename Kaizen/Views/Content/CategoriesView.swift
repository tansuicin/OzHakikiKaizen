//
//  CategoriesView.swift
//  Kaizen
//
//  Created by Tansu ICIN on 16.12.2023.
//

import SwiftUI

struct CategoriesView: View {
    @Binding var categories: [Category]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewScrumView = false
    let saveAction: ()->Void
    @State var showAlert:Bool = false
    @State private var isShow = false
    @State private var cIndexSet: IndexSet?

    var body: some View {
        NavigationStack {
            List{
                ForEach($categories){ $category in
                    NavigationLink(destination: DetailView(category: $category)) {
                        CardView(category: category)
                            .confirmationDialog("Are you sure you want to permanently delete this item ?", isPresented: $isShow, titleVisibility: .visible)
                        {
                            Button("Cancel", role:.cancel){
                                isShow = false
                            }
                            Button("Delete", role:.destructive){
                                categories.remove(atOffsets: cIndexSet!)
                                isShow = false
                            }
                        }
                        }
                        .deleteDisabled(category.notes.count > 0 ? true : false)
                        .listRowBackground(category.theme.mainColor)
                }
                .onMove(perform: { indices, newOffset in
                    categories.move(fromOffsets: indices, toOffset: newOffset)
                })
                .onDelete(perform: { indices in
                    isShow = true
                    cIndexSet = indices
                    //let index =  indices[indices.startIndex]
                    //categories.remove(atOffsets: indices)
                })
                
            }
            .navigationTitle("Notes")
            .toolbar {
                Button(action: {
                    isPresentingNewScrumView = true
                }) {
                    Image(systemName: "plus.app")
                }
            }
        }
        .sheet(isPresented: $isPresentingNewScrumView) {
            NewCategorySheet(categories: $categories, isPresentingNewScrumView: $isPresentingNewScrumView)
        }
        .onChange(of: scenePhase) {
            if scenePhase == .inactive { saveAction() }
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(categories: .constant(Category.sampleData), saveAction: {})
    }
}
