//
//  ContentView.swift
//  Book Lover
//
//  Created by Huy Ong on 7/14/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @FetchRequest var coreDataBooks: FetchedResults<CDBook>
    @Environment(\.managedObjectContext) private var context
    
    @State private var showSearching = false
    
    init() {
        let request = NSFetchRequest<CDBook>(entityName: "CDBook")
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        _coreDataBooks = FetchRequest(fetchRequest: request)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(coreDataBooks.indices, id: \.self) { index in
                    NavigationLink(destination: BookCardDetail(book: coreDataBooks[index])) {
                        BookCard(book: coreDataBooks[index])
                    }
                }
                .onDelete { (indexSet) in
                    guard let index = indexSet.first else { return }
                    context.delete(coreDataBooks[index])
                    try? context.save()
                }
            }
            .listStyle(PlainListStyle())
            .sheet(isPresented: $showSearching) {
                SearchBookView(isShowSearh: $showSearching).environment(\.managedObjectContext, context)
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


