//
//  DetailView.swift
//  Kaizen
//
//  Created by Tansu ICIN on 16.12.2023.
//deneme
//deneme
//deneme

import SwiftUI

struct DetailView: View {
    @Binding var category: Category
    @State private var editingScrum = Category.emptyNote
    @State private var newAttendeeName = ""

    @State private var isPresentingEditView = false
    @State private var isShow = false
    @State private var cIndexSet: IndexSet?
    
    var body: some View {
        NavigationStack{
            List  {
                ForEach($category.notes) { $note in
                    NavigationLink(destination: NoteEditView(note: $note)) {
                        Text("\(note.name)")
                            .confirmationDialog("Are you sure you want to permanently delete this item ?", isPresented: $isShow, titleVisibility: .visible)
                        {
                            Button("Cancel", role:.cancel){
                                isShow = false
                            }
                            Button("Delete", role:.destructive){
                                category.notes.remove(atOffsets: cIndexSet!)
                                isShow = false
                            }
                        }
                    }
                }
                .onMove(perform: { indices, newOffset in
                    category.notes.move(fromOffsets: indices, toOffset: newOffset)
                })
                .onDelete { indices in
                    isShow = true
                    cIndexSet = indices
                   // category.notes.remove(atOffsets: indices)
                }
                HStack {
                    TextField("Add", text: $newAttendeeName, axis: .vertical)
                    //TextField("Add", text: $newAttendeeName)
                        .scaledToFill()
                        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    Button(action: {
                        withAnimation {
                            let attendee = Category.Note(name: newAttendeeName)
                            category.notes.append(attendee)
                            newAttendeeName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
            }
            .navigationTitle(category.title)
            .toolbar {
                Button("Edit") {
                    isPresentingEditView = true
                    editingScrum = category
                }
            }
            

        }
        

        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                DetailEditView(category: $editingScrum)
                    .navigationTitle(category.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                category = editingScrum
                            }
                        }
                    }
            }
        }
    }
}



struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(category: .constant(Category.sampleData[0]))
        }
    }
}
