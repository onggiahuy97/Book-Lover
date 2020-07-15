//
//  SearchBar.swift
//  Book Lover
//
//  Created by Huy Ong on 7/14/20.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    @Binding var books: [BookAPIResult]
    @Binding var isSearching: Bool
    
    func makeCoordinator() -> Coordinator {
        Coordinator(books: $books, isSearching: $isSearching)
    }
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var books: [BookAPIResult]
        @Binding var isSearching: Bool
        
        init(books: Binding<[BookAPIResult]>, isSearching: Binding<Bool>) {
            _books = books
            _isSearching = isSearching
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.endEditing(true)
            self.books = []
            isSearching = true
            
            guard let searchTerm = searchBar.text else { return }
            APIService.shared.fetchBooks(searchTerm: searchTerm) { [weak self] (result) in
                self?.isSearching = false
                switch result {
                case .failure(let err):
                    print("Failed to fetch books", err)
                case .success(let bookResults):
                    self?.books = bookResults.results
                }
            }
        }
    }
    
    func makeUIView(context: Context) -> UIView {
        let searchBar = UISearchBar()
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        return searchBar
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    typealias UIViewType = UIView
    
}
