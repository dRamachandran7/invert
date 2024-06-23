//
//  Color++.swift
//  prodapp
//
//  Created by Dhruva Ramachandran on 3/31/24.
//

import Foundation
import SwiftUI

extension Color {
    static let primary: Color = .init(hex: 0x388091)
    static let secondary: Color = .init(hex: 0xE66460)
    static let buttonBlue: Color = .init(hex: 0x55C2C9)
    static let onBackgroundPrimary: Color = .init(hex: 0x252525)
    static let onBackgroundSecondary: Color = .init(hex: 0xa37cc3)
    static let onBackgroundTertiary: Color = .init(hex: 0xf6c2f3)
    static let textOnPastel: Color = .init(hex: 0xC7F8F9)
}

private extension Color {
    init(hex: UInt) { self.init(.sRGB, red: Double((hex >> 16) & 0xff) / 255, green: Double((hex >> 08) & 0xff) / 255, blue: Double((hex >> 00) & 0xff) / 255, opacity: 1) }
}
