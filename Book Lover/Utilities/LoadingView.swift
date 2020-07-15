//
//  LoadingView.swift
//  Book Lover
//
//  Created by Huy Ong on 7/14/20.
//

import SwiftUI

struct LoadingView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let loadingView = UIActivityIndicatorView()
        loadingView.startAnimating()
        loadingView.style = .medium
        return loadingView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    
    }
    
    typealias UIViewType = UIView
    
}
