//
//  AddProgressUpdate.swift
//  Book Lover
//
//  Created by Huy Ong on 7/14/20.
//

import SwiftUI
import CoreData

struct AddProgressUpdate: View {
    @Environment(\.managedObjectContext) var context

    var book: CDBook

    @Binding var isShowAdd: Bool

    @State private var progress: CGFloat = 0
    @State private var text = ""
    
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: HStack {
                        Text("Progress")
                        Spacer()
                        Text("\(Int(progress * 100))%")
                    }) {
                        Slider(value: $progress, in: 0...1)
                            .onAppear {
                                progress = CGFloat(book.progress)
                            }
                    }
                    
                    Section(header: Text("Note")) {
                        TextField("Type here", text: $text)
                    }
                }
            }
            .modifier(modifyNavigation(book: book, progress: $progress, text: $text, isShowAdd: $isShowAdd))
        }
    }
    
    private struct modifyNavigation: ViewModifier {
        @Environment(\.managedObjectContext) var context
        
        var book: CDBook
        
        @Binding var progress: CGFloat
        @Binding var text: String
        @Binding var isShowAdd: Bool
        
        func body(content: Content) -> some View {
            content
                .navigationBarTitle(Text("Updating Progress"), displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    isShowAdd = false
                }) {
                    Text("Cancel")
                }, trailing: Button(action: {
                    let update = NSEntityDescription.insertNewObject(forEntityName: "CDBookUpdate", into: context) as! CDBookUpdate
                    update.date = Date()
                    update.note = text
                    update.progress = Double(progress)
                    update.book = book
                    
                    book.progress = Double(progress)
                    
                    do { try context.save() } catch let err { print("Failed to save", err) }
                    
                    isShowAdd = false
                }) {
                    Text("Save")
                })
        }
    }
}
