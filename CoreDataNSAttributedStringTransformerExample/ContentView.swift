//
//  ContentView.swift
//  CoreDataNSAttributedStringTransformerExample
//
//  Created by yueyue max on 2023/1/12.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Note.createTime, ascending: true)],
        animation: .default)
    private var notes: FetchedResults<Note>

    var body: some View {
        List {
            Button(action: {
                Note.addNote()
            }) {
                Text("Add One Note")
            }

            Section {
                ForEach(notes, id: \.id) { note in
                    VStack(alignment: .leading) {
                        AttributedText(note.attributedContent ?? NSAttributedString(string: "Default content if note content is empty."))
                        Text((note.createTime ?? Date()).formatted(date: .abbreviated, time: .standard))
                    }
                }
                .onDelete(perform: removeNote(at:))
            }
        }
    }

    func removeNote(at offsets: IndexSet) {
        for index in offsets {
            let note = notes[index]
            viewContext.delete(note)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
