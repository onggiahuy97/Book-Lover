//
//  TestCoreData.swift
//  Book Lover
//
//  Created by Huy Ong on 7/15/20.
//

import SwiftUI
import CoreData

struct TestCoreData: View {
    @FetchRequest var coreDataBooks: FetchedResults<CDBook>
    @Environment(\.managedObjectContext) private var context
    
    init() {
        let request = NSFetchRequest<CDBook>(entityName: "CDBook")
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        _coreDataBooks = FetchRequest(fetchRequest: request)
    }
    
    var body: some View {
        List {
            Button(action: {
                let book = CDBook(context: context)
                book.title = "Born a crime"
                book.author = "Trevor Noar"
                book.progress = 0
                book.image = UIImage(named: "sample")?.jpegData(compressionQuality: 0.8)
                try? context.save()
            }) {
                Text("Add")
            }
            ForEach(coreDataBooks.indices, id: \.self) { index in
                Text(coreDataBooks[index].title ?? "")
            }
            .onDelete { indexSet in
                context.delete(coreDataBooks[indexSet.first ?? 0])
                try? context.save()
                
            }
        }
    }
}

struct TestCoreData_Previews: PreviewProvider {
    static var previews: some View {
        TestCoreData()
    }
}
