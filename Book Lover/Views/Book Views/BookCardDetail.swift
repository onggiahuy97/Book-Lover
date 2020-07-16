//
//  BookCardDetail.swift
//  Book Lover
//
//  Created by Huy Ong on 7/14/20.
//

import SwiftUI

struct BookCardDetail: View {
    @Environment(\.managedObjectContext) var context
    
    @ObservedObject var book: CDBook
    
    @State var isUpdating = false
    
    var body: some View {
        VStack {
            BookCard(book: book)
                .padding(.horizontal)
            
            Divider()
            
            Button(action: {
                isUpdating = true
            }) {
                HStack {
                    Image(systemName: "book.circle")
                    Text("Update New Progress")
                }
                .padding(.vertical, 5)
            }
            .sheet(isPresented: $isUpdating, onDismiss: nil) {
                AddProgressUpdate(book: book, isShowAdd: $isUpdating)
                    .environment(\.managedObjectContext, context)
            }
            
            Divider()
            List {
                if let bookUpdates = book.updates?.allObjects as? [CDBookUpdate] {
                    ForEach(0..<bookUpdates.count, id: \.self) { index in
                        NavigationLink(destination: DetailProgressUpdate(update: bookUpdates[index])) {
                            ProgressUpdateView(update: bookUpdates[index])
                        }
                        
                    }
                }
            }
        }
        .padding(.top, 10)
        .navigationBarTitle(Text(book.title ?? ""), displayMode: .inline)
//        .navigationBarItems(trailing: Button(action: {
//            guard let updatesData = book.updates?.allObjects as? [CDBookUpdate] else { return }
//            updates = updatesData.sorted { $0.date! < $1.date! }
//        }) {
//            Text("Fetch updates")
//        })
    }
}

