//
//  File.swift
//  
//
//  Created by András Samu on 2019. 07. 19..
//

import Foundation
import SwiftUI
public struct Colors {
    public static let color1:Color = Color(hexString: "#E2FAE7")
    public static let color1Accent:Color = Color(hexString: "#72BF82")
    public static let color2:Color = Color(hexString: "#EEF1FF")
    public static let color2Accent:Color = Color(hexString: "#4266E8")
    public static let color3:Color = Color(hexString: "#FCECEA")
    public static let color3Accent:Color = Color(hexString: "#E1614C")
}


extension Color {
    init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (r, g, b) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0, 0, 0)
        }
        self.init(red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255)
    }
}
