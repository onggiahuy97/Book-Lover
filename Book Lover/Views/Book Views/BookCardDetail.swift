//
//  BookCardDetail.swift
//  Book Lover
//
//  Created by Huy Ong on 7/14/20.
//

import SwiftUI

struct BookCardDetail: View {
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var context
    @ObservedObject var book: CDBook
    @State var isUpdating = false
    @State var showDelete = false
    
    var body: some View {
        VStack {
            BookCard(book: book)
                .padding(.horizontal)
            
            Divider()
            
            Button(action: {
                isUpdating = true
            }) {
                HStack(alignment: .center) {
                    Spacer()
                    Image(systemName: "book.circle")
                    Text("Update New Progress")
                    Spacer()
                }
            }
            .padding(.vertical, 3)
            .sheet(isPresented: $isUpdating, onDismiss: nil) {
                AddProgressUpdate(isShowAdd: $isUpdating, book: book)
                    .environment(\.managedObjectContext, context)
            }
            
            Divider()
            
            List {
                if let bookUpdatesUnsorted = book.updates?.allObjects as? [CDBookUpdate],
                   let bookUpdates = bookUpdatesUnsorted.sorted { $0.date! < $1.date! } {
                    ForEach(0..<bookUpdates.count, id: \.self) { index in
                        NavigationLink(destination: DetailProgressUpdate(update: bookUpdates[index], book: book)) {
                            ProgressUpdateView(update: bookUpdates[index])
                        }
                    }
                }
            }
        }
        .padding(.top, 10)
        .navigationBarTitle(Text(book.title ?? ""), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            showDelete.toggle()
        }) {
            Image(systemName: "trash")
                .imageScale(.large)
                .foregroundColor(Color("AccentColor"))
        })
        .alert(isPresented: $showDelete, content: deleteBookWithAlert)
    }
    
    func delete(bookUpdata: CDBookUpdate) {
        book.removeFromUpdates(bookUpdata)
        try? context.save()
    }
    
    func deleteBookWithAlert() -> Alert {
        Alert(title: Text("Delete this book?"), primaryButton: .cancel(), secondaryButton: .destructive(Text("Yes"), action: {
            context.delete(book)
            try? context.save()
            presentation.wrappedValue.dismiss()
        }))
    }
}
