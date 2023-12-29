//
//  CardView.swift
//  Kaizen
//
//  Created by Tansu ICIN on 16.12.2023.
//lhlhlhll

import SwiftUI

struct CardView: View {
    let category: Category
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text(category.title)
                    .font(.headline)
                Spacer()
                Text("\(category.notes.count)")
                    .font(.headline)
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(category.theme.accentColor)
    }
}

struct CardView_Previews: PreviewProvider {
    static var category = Category.sampleData[0]
    static var previews: some View {
        CardView(category: category)
            .background(category.theme.mainColor)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
