//
//  Book.swift
//  Book Lover
//
//  Created by Huy Ong on 7/14/20.
//

import Foundation

struct Book: Hashable {
    let title: String
    let author: String
    let image: String
    var progress: Double
    var updates: [BookUpdate]
}

struct BookUpdate: Hashable {
    var progress: Double
    var date: Date
    var note: String
}

