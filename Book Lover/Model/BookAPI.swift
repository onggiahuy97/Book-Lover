//
//  BookAPI.swift
//  Book Lover
//
//  Created by Huy Ong on 7/14/20.
//

import Foundation

struct BookAPI: Decodable {
    let results: [BookAPIResult]
}

struct BookAPIResult: Decodable, Hashable {
    let artworkUrl100: String
    let trackName: String
    let artistName: String
}
