//
//  Date+Extension.swift
//  Book Lover
//
//  Created by Huy Ong on 7/14/20.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self)
    }
}
