//
//  DetailEditView.swift
//  Kaizen
//
//  Created by Tansu ICIN on 16.12.2023.
//

import SwiftUI

struct DetailEditView: View {
    @Binding var category: Category

    var body: some View {
        NavigationStack{
            Form {
                Section(header: Text("Name")) {
                    TextField("", text: $category.title)
                        .scaledToFill()
                }
                Section(header: Text("Color")) {
                    ThemePicker(selection: $category.theme)
                }
            }
            .navigationTitle("Category")
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(category: .constant(Category.sampleData[0]))
    }
}
