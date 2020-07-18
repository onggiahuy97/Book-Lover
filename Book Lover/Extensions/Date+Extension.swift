//
//  Date+Extension.swift
//  Book Lover
//
//  Created by Huy Ong on 7/14/20.
//

import Foundation

extension Date {
    func toString(style: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
}
