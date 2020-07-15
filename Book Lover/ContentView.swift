//
//  ContentView.swift
//  Book Lover
//
//  Created by Huy Ong on 7/14/20.
//

import SwiftUI


struct ContentView: View {
    @State private var showSearching = false
    
    @ObservedObject var model = BookViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(model.books.indices, id: \.self) { index in
                    NavigationLink(destination: BookCardDetail(book: $model.books[index])) {
                        BookCard(book: model.books[index])
                    }
                }
            }
            .environmentObject(model)
            .listStyle(PlainListStyle())
            .sheet(isPresented: $showSearching) {
                SearchBookView()
            }
            .navigationTitle(Text("Books"))
            .navigationBarItems(trailing: Button(action: {
                showSearching = true
            }) {
                Text("Add book")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


