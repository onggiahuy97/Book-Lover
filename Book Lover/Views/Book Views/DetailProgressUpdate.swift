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
    
    @State private var isDeleting = false
    
    var book: CDBook
    
    var body: some View {
        Form {
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
            
            Section(header: Text("Quick note")) {
                Text(update.note ?? "")
            }
            
            Section {
                Button(action: {
                    isDeleting = true
                }) {
                    HStack {
                        Spacer()
                        Image(systemName: "trash")
                        Text("Delete")
                        Spacer()
                    }.foregroundColor(.red)
                }
            }
        }
        .actionSheet(isPresented: $isDeleting) {
            ActionSheet(title: Text("Delete this note?"), buttons: [
                ActionSheet.Button.cancel(),
                ActionSheet.Button.destructive(Text("Delete"), action: {
                    book.removeFromUpdates(update)
                    try? context.save()
                    presentation.wrappedValue.dismiss()
                }),
            ])
        }
    }
}

