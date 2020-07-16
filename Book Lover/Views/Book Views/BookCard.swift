//
//  BookCard.swift
//  Book Lover
//
//  Created by Huy Ong on 7/14/20.
//

import SwiftUI

struct BookCard: View {
    @Environment(\.managedObjectContext) var context
    
    @ObservedObject var book: CDBook
    
    let width: CGFloat = 86
    let scale: CGFloat = 1.45
    
    var body: some View {
        HStack(spacing: 10) {
            Image(uiImage: UIImage(data: book.image ?? Data()) ?? UIImage())
                .resizable()
                .frame(width: width, height: width * scale)
                .cornerRadius(3.0)
                .shadow(radius: 10, x: 0, y: 5)
            
            VStack(alignment: .leading) {
                Text(book.title ?? "")
                    .font(.headline)
                
                Text(book.author ?? "")
                    .font(.subheadline)
                    .foregroundColor(Color(.secondaryLabel))
            }
            
            Spacer()
            
            ProgressRing(progress: CGFloat(book.progress))
        }
    }
}
