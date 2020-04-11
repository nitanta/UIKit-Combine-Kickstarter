//
//  Color.swift
//  Book share
//
//  Created by Nitanta Adhikari on 3/30/19.
//  Copyright © 2019 The K Tech. All rights reserved.
//

import Foundation
import UIKit

struct Color {
    static let primary = UIColor(hexString: "#03DAC6")
    static let primaryLight = UIColor(hexString: "#A8FFFB")
    static let primaryLighter = UIColor(hexString: "#A8FFFB")
    static let dark = UIColor(hexString: "#000000")
    static let paginationLight = UIColor(hexString: "#A8FFFB")
    static let blue = UIColor(hexString: "#3C60B2")
    static let yellow = UIColor(hexString: "#FFD500")
    static let background = UIColor(hexString: "#F7F7F7")
    static let red = UIColor(hexString: "#942121")
    static let green = UIColor(hexString: "#2DB744")
    static let orange = UIColor.orange
    static let purple = UIColor.purple
    static let primaryAddBook = UIColor(hexString: "#A8FFFB")
    static let primaryAddBookBorder = UIColor(hexString: "#A8FFFB")
}

struct AppColor {
    static let Alpha64 = Color.dark.withAlphaComponent(0.64)
    static let Alpha60 = Color.dark.withAlphaComponent(0.60)
    static let Alpha90 = Color.dark.withAlphaComponent(0.90)
    static let Alpha38 = Color.dark.withAlphaComponent(0.38)
    static let Alpha30 = Color.dark.withAlphaComponent(0.30)
    static let Alpha87 = Color.dark.withAlphaComponent(0.87)
    static let Alpha67 = Color.dark.withAlphaComponent(0.67)
    static let Alpha12 = Color.dark.withAlphaComponent(0.12)
    static let Alpha32 = Color.dark.withAlphaComponent(0.32)
    static let PrimaryAddBookAlpha12 = Color.primaryAddBook.withAlphaComponent(0.12)
    static let PrimaryAddBookBorderAlpha32 = Color.primaryAddBookBorder.withAlphaComponent(0.32)
    static let PrimaryAlpha32 = Color.primary.withAlphaComponent(0.32)
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
