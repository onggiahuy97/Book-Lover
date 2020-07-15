//
//  SearchBookView.swift
//  Book Lover
//
//  Created by Huy Ong on 7/14/20.
//

import SwiftUI

struct SearchBookView: View {
    @State private var books = [BookAPIResult]()
    @State private var isSearching = true
//    @Binding var book: Book
    
    var body: some View {
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
                                    .onTapGesture {
                                        
                                    }
                            }
                        }
                    }
                }
            }
        }
    }
}



struct SearchBookView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBookView()
    }
}
