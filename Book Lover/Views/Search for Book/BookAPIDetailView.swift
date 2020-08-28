//
//  BookAPIDetailView.swift
//  Book Lover
//
//  Created by Huy Ong on 7/14/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookAPIDetailView: View {
    var book: BookAPIResult
    
    let screen = UIScreen.main.bounds
    let width: CGFloat = 86
    let scale: CGFloat = 1.45
    
    var body: some View {
        HStack {
            WebImage(url: URL(string: book.artworkUrl100))
                .renderingMode(.original)
                .resizable()
                .frame(width: width, height: width * scale)
                .cornerRadius(3.0)
                .shadow(radius: 5, x: 0, y: 5)
            
            VStack(alignment: .leading) {
                Text(book.trackName)
                    .font(.headline)
                    .foregroundColor(Color("textColor"))
                
                Text(book.artistName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .frame(height: width * scale + 10)
//        .frame(width: screen.width, height: width * scale + 10)
    }
}
