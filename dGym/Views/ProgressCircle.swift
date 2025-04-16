//
//  ProgressCircle.swift
//  dGym
//
//  Created by Daniel Harris on 16/04/2025.
//

import SwiftUI

struct ProgressCircle: View {
    @EnvironmentObject var themeManager: ThemeManager
    let value: Double
    let total: Double
    let label: String
    
    private var percentage: Double {
        total > 0 ? min(value / total, 1.0) : 0
    }
    
    var body: some View {
        VStack {
            ZStack {
                // Background circle
                Circle()
                    .stroke(lineWidth: 10)
                    .opacity(0.2)
                    .foregroundColor(themeManager.accentColor)
                
                // Progress circle
                Circle()
                    .trim(from: 0.0, to: CGFloat(percentage))
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .foregroundColor(themeManager.accentColor)
                    .rotationEffect(Angle(degrees: 270))
                    .animation(.linear, value: percentage)
                
                // Label
                Text("\(label)")
                    .font(.title3)
                    .bold()
                    .foregroundColor(themeManager.textColor)
                    .offset(y: 25)
                
            }
            .frame(width: 100, height: 100)
            
            // Total value
            Text("of \(Int(total))")
                .font(.caption)
                .foregroundColor(themeManager.secondaryTextColor)
        }
    }
}

