//
//  Color.swift
//  * stoic (iOS)
//
//  Created by PEXAVC on 12/20/20.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    var asNSColor: NSColor {
        NSColor(self)
    }
    
}

extension Color {
    typealias RGBA = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
    var rgba: RGBA? {
        var (r, g, b, a): RGBA = (0, 0, 0, 0)
        
        self.asNSColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        
        return (r, g, b, a)
    }
    var hexaRGB: String? {
        guard let (red, green, blue, _) = rgba else { return nil }
        return String(format: "#%02x%02x%02x",
                      Int(red * 255),
                      Int(green * 255),
                      Int(blue * 255))
    }
    var hexaRGBA: String? {
        guard let (red, green, blue, alpha) = rgba else { return nil }
        return String(format: "#%02x%02x%02x%02x",
                      Int(red * 255),
                      Int(green * 255),
                      Int(blue * 255),
                      Int(alpha * 255))
    }
}
