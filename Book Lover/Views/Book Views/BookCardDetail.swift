//
//  BookCardDetail.swift
//  Book Lover
//
//  Created by Huy Ong on 7/14/20.
//

import SwiftUI

struct BookCardDetail: View {
    @State private var isUpdating = false
    
    @Binding var book: Book
    
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
                AddProgressUpdate(book: $book)
            }
            
            Divider()
            List {
                ForEach(book.updates, id: \.self) { update in
                    NavigationLink(destination: DetailProgressUpdate(update: update)) {
                        ProgressUpdateView(update: update)
                    }
                }
            }
        }
        .padding(.top, 10)
        .navigationBarTitle(Text(book.title), displayMode: .inline)
    }
}

