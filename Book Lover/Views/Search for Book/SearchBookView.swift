//
//  SearchBookView.swift
//  Book Lover
//
//  Created by Huy Ong on 7/14/20.
//

import SwiftUI

struct SearchBookView: View {
    @Environment(\.presentationMode) var presentation
    
    @State private var books = [BookAPIResult]()
    @State private var isSearching = true
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(books: $books, isSearching: $isSearching)
                
                if isSearching {
                    LoadingView()
                    Spacer()
                } else {
                    if books.isEmpty {
                        Text("Can't find the book")
                        Spacer()
                    } else {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 10) {
                                ForEach(books, id: \.self) { book in
                                    BookAPIDetailView(book: book)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Search", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                presentation.wrappedValue.dismiss()
            }) {
                Text("Cancel")
            })
        }
    }
}



struct SearchBookView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBookView()
    }
}
