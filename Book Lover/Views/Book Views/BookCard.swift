//
//  BookCard.swift
//  Book Lover
//
//  Created by Huy Ong on 7/14/20.
//

import SwiftUI

struct BookCard: View {
    
    var book: Book
    
    let width: CGFloat = 86
    let scale: CGFloat = 1.45
    
    var body: some View {
        HStack(spacing: 10) {
            Image(book.image)
                .resizable()
                .frame(width: width, height: width * scale)
                .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                .shadow(radius: 10, x: 0, y: 5)
            
            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.headline)
                
                Text(book.author)
                    .font(.subheadline)
                    .foregroundColor(Color(.secondaryLabel))
            }
            
            Spacer()
            
            ProgressRing(progress: CGFloat(book.progress))
        }
    }
}



//struct BookCard_Previews: PreviewProvider {
//    static var previews: some View {
//        BookCard()
//    }
//}
