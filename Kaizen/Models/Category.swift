//
//  Category.swift
//  Kaizen
//
//  Created by Tansu ICIN on 16.12.2023.
//

import Foundation

struct Category: Identifiable, Codable {
    let id: UUID
    var title: String
    var notes: [Note]
    var theme: Theme
   
    
    init(id: UUID = UUID(), title: String, notes: [Note],  theme: Theme) {
        self.id = id
        self.title = title
        self.notes = notes
        self.theme = theme
    }
}

extension Category {
    struct Note: Identifiable, Codable {
        let id: UUID
        var name: String
        var created: Date
        
        init(id: UUID = UUID(), name: String, created: Date = Date.now) {
            self.id = id
            self.name = name
            self.created = created
        }
    }
    
    static var emptyNote: Category {
        Category(title: "", notes: [], theme: .sky)
    }
}

extension Category {
    static let sampleData: [Category] =
    [
        Category(title: "Design",
                   notes: [Note(name: "Cathy"), Note(name: "Daisy")],
                   theme: .yellow),
        Category(title: "App Dev",
                   notes:[Note(name: "Cathy"), Note(name: "Daisy")],
                   theme: .orange),
       
    ]
}

