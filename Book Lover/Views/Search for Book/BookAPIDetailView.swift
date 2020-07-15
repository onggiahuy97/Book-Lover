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
    
    var body: some View {
        HStack {
            WebImage(url: URL(string: book.artworkUrl100))
                .resizable()
                .scaledToFit()
                .shadow(radius: 10)
                .cornerRadius(5)
            
            VStack(alignment: .leading) {
                Text(book.trackName)
                    .font(.headline)
                Text(book.artistName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .frame(width: screen.width, height: 100)
    }
}
