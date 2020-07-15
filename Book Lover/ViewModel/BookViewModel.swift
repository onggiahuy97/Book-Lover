//
//  BookViewModel.swift
//  Book Lover
//
//  Created by Huy Ong on 7/14/20.
//

import SwiftUI

class BookViewModel: ObservableObject {
    @Published var books: [Book] = [
        Book(title: "Born A Crime", author: "Trevor Noar", image: "sample", progress: 0.45, updates: [.init(progress: 0.23, date: Date(), note: "Test data Test data Test data Test data Test data Test data Test data Test data Test data Test data Test data Test data Test data Test data"), .init(progress: 0.34, date: Date(), note: "Next test")])
    ]
}
