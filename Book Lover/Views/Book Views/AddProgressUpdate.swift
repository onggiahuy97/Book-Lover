//
//  AddProgressUpdate.swift
//  Book Lover
//
//  Created by Huy Ong on 7/14/20.
//

import SwiftUI

struct AddProgressUpdate: View {
    @Binding var book: Book
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
            .modifier(modifyNavigation(book: $book, progress: $progress, text: $text))
        }
    }
    
    private struct modifyNavigation: ViewModifier {
        @Environment(\.presentationMode) var presentationMode
        @Binding var book: Book
        @Binding var progress: CGFloat
        @Binding var text: String
        
        func body(content: Content) -> some View {
            content
                .navigationBarTitle(Text("Updating Progress"), displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    dismiss()
                }) {
                    Text("Cancel")
                }, trailing: Button(action: {
                    let bookUpdate = BookUpdate(progress: Double(progress), date: Date(), note: text)
                    book.updates.append(bookUpdate)
                    book.progress = Double(progress)
                    dismiss()
                }) {
                    Text("Save")
                })
        }
        private func dismiss() {
            presentationMode.wrappedValue.dismiss()
        }
    }
}
