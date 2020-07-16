//
//  DetailProgressUpdate.swift
//  Book Lover
//
//  Created by Huy Ong on 7/14/20.
//

import SwiftUI

struct DetailProgressUpdate: View {
    var update: CDBookUpdate
    
    var body: some View {
        Form {
            Section(header: Text("Progress")) {
                ProgressUpdateView(update: update)
            }
            
            Section(header: Text("Note")) {
                Text(update.note ?? "")
            }
        }
    }
}
