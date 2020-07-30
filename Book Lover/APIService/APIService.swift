//
//  APIService.swift
//  Book Lover
//
//  Created by Huy Ong on 7/14/20.
//

import Foundation

class APIService {
    static let shared = APIService()
    
    func fetchBooks(searchTerm: String, completion: @escaping (Result<BookAPI, Error>) -> ()) {
        let fixSearchTerm = searchTerm.replacingOccurrences(of: " ", with: "+").replacingOccurrences(of: "'", with: "")
        let urlString = "https://itunes.apple.com/search?term=\(fixSearchTerm)&entity=ebook&limit=25"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    fileprivate func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> ()) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            
            do {
                guard let data = data else { return }
                let results = try JSONDecoder().decode(T.self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(error))
            }
            
        }
        .resume()
    }
}
