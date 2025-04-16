//
//  ColorTheme.swift
//  dGym
//
//  Created by Daniel Harris on 15/04/2025.
//

import Foundation
import SwiftUI

extension Color {
    static let backgroundColor = Color.black
    static let primaryTextColor = Color.white
    static let secondaryTextColor = Color.gray
    static let accentColor = Color("AccentColor") // Bright yellow
    static let cardBackground = Color.white
    static let selectedBackground = Color("AccentColor")
    static let unselectedBackground = Color(white: 0.2)
}

struct AppTheme {
    static let cornerRadius: CGFloat = 8
    static let navigationBarTitleFont = Font.system(size: 20, weight: .bold)
    static let headerFont = Font.system(size: 17, weight: .semibold)
    static let bodyFont = Font.system(size: 15, weight: .regular)
    static let smallFont = Font.system(size: 13, weight: .regular)
}
