//
//  DetailProgressUpdate.swift
//  Book Lover
//
//  Created by Huy Ong on 7/14/20.
//

import SwiftUI

struct DetailProgressUpdate: View {
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var context
    
    @ObservedObject var update: CDBookUpdate
    
    @State private var showEdit = false
    @State private var isDeleting = false
    @State private var text = ""
    
    @ObservedObject var book: CDBook
    
    var body: some View {
        Form {
            // MARK: - Progress
            Section(header: Text("Progress")) {
                HStack {
                    Text("Progress").foregroundColor(Color.secondary)
                    Spacer()
                    Text("\(Int(update.progress * 100))%")
                }
                HStack {
                    Text("Date").foregroundColor(Color.secondary)
                    Spacer()
                    Text((update.date?.toString(style: .full) ?? "N/A"))
                }
            }
            
            // MARK: - Note
            Section(header: HStack {
                Text("Note")
                Spacer()
                Button(action: {
                    showEdit = true
                    text = update.note ?? ""
                }) {
                    Text("Edit").foregroundColor(Color("AccentColor"))
                }
            }) {
                Text(update.note ?? "")
            }
            .sheet(isPresented: $showEdit, onDismiss: {
                update.note = text
                try? context.save()
            }) {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: { showEdit = false }) { Text("Done") }
                    }
                    EditNoteView(text: $text)
                    
                }
                .padding()
            }
            
            // MARK: - Delete Note
            Section {
                Button(action: {
                    isDeleting = true
                }) {
                    HStack {
                        Spacer()
                        Image(systemName: "trash")
                        Text("Delete")
                        Spacer()
                    }
                    .foregroundColor(.red)
                }
            }
        }
        .actionSheet(isPresented: $isDeleting) {
            delete()
        }
    }
}

extension DetailProgressUpdate {
    func delete() -> ActionSheet {
        ActionSheet(title: Text("Delete this note?"), buttons: [
            ActionSheet.Button.cancel(),
            ActionSheet.Button.destructive(Text("Delete"), action: {
                book.removeFromUpdates(update)
                if book.updates?.count == 0 { book.progress = 0.01 }
                if book.updates?.count == 1 {
                    if let bookUpdates = book.updates?.allObjects as? [CDBookUpdate] {
                        let progress = bookUpdates.first!.progress
                        book.progress = progress
                    }
                }
                if book.updates?.count ?? 0 > 1 {
                    if let bookUpdatesUnsorted = book.updates?.allObjects as? [CDBookUpdate] {
                        let bookUpdatesSorted = bookUpdatesUnsorted.sorted { $0.date! < $1.date! }
                        let progress = bookUpdatesSorted.last!.progress
                        book.progress = progress
                    }
                }
                try? context.save()
                presentation.wrappedValue.dismiss()
            }),
        ])
    }
}
