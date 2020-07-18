//
//  SearchBookView.swift
//  Book Lover
//
//  Created by Huy Ong on 7/14/20.
//

import SwiftUI

struct SearchBookView: View {
    @Environment(\.managedObjectContext) var context
    
    @Binding var isShowSearh: Bool
    
    @State private var books = [BookAPIResult]()
    @State private var selectedBook: BookAPIResult?
    @State private var isSearching = true
    @State private var isConforming = false
    
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
                                    Button(action: {
                                        isConforming = true
                                        selectedBook = book
                                    }) {
                                        BookAPIDetailView(book: book)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Search", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                isShowSearh = false
            }) {
                Text("Cancel")
            })
            .alert(isPresented: $isConforming) {
                Alert(
                    title: Text("Pick this book?"),
                    message: Text("Add to library"),
                    primaryButton: .default(Text("Yes!"), action: {
                        pickThisBook(book: selectedBook!)
                        isShowSearh = false
                    }),
                    secondaryButton: .cancel())
            }
        }
    }
    
    fileprivate func pickThisBook(book: BookAPIResult) {
        let selectedBook = CDBook(context: context)
        selectedBook.title = book.trackName
        selectedBook.author = book.artistName
        selectedBook.progress = 0.01
        
        URLSession.shared.dataTask(with: URL(string: book.artworkUrl100)!) { (data, _, err) in
            if let err = err {
                print("Failed to donwload book image", err)
                return
            }
            guard let data = data else { return }
            selectedBook.image = UIImage(data: data)?.jpegData(compressionQuality: 0.8)
        }.resume()
        
        do { try context.save() } catch let err { print("Failed to save context", err) }
        
    }
}

