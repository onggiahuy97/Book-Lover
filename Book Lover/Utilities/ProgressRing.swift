//
//  ProgressRing.swift
//  Book Lover
//
//  Created by Huy Ong on 7/14/20.
//

import SwiftUI

struct ProgressRing: View {
    var progress: CGFloat
    
    let radius: CGFloat = 25
    let lineWidth: CGFloat = 3
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(.black).opacity(0.1), style: StrokeStyle(lineWidth: lineWidth))
                .frame(width: radius, height: radius)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [Color("AccentColor"), Color("AccentColor")]), startPoint: .topTrailing, endPoint: .bottomLeading),
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0)
                )
                .rotationEffect(Angle(degrees: -90))
                .frame(width: radius, height: radius)
                .shadow(radius: 10)
        }
    }
}

