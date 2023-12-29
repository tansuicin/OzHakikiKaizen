//
//  NoteEditView.swift
//  Kaizen
//
//  Created by Tansu ICIN on 16.12.2023.
//

import SwiftUI
import Foundation

struct NoteEditView: View {
    @Binding var note: Category.Note
   
    
    var body: some View {
        NavigationStack{
            Form {
                Section(header: Text("Note")) {
                    TextField("Title", text: $note.name, axis: .vertical)
                        .lineLimit(6, reservesSpace: true)
                        .scaledToFill()
                }
                Section(header: Text("Created")) {
                    HStack {
                        Text(FormatDate(vDate: note.created))
                        Spacer()
                        Text(note.created, style: .offset)
                    }
                }
            }
            .navigationTitle("Edit Note")
        }
    }
}

func FormatDate(vDate: Date) -> String{
    let formatter = DateFormatter();
    formatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
    return formatter.string(from: vDate)
}


#Preview {
    NoteEditView(note: .constant(Category.sampleData[0].notes[0]))
}
