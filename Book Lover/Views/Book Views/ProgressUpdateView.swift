//
//  ProgressUpdateView.swift
//  Book Lover
//
//  Created by Huy Ong on 7/14/20.
//

import SwiftUI

struct ProgressUpdateView: View {
    var update: CDBookUpdate
    
    var body: some View {
        HStack {
            Text("\(Int(update.progress * 100))%")
            Spacer()
            Text(update.date?.toString() ?? "N/A")
        }
    }
}
